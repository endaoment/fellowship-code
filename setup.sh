#!/bin/bash

# =============================================================================
# Fellowship Code - Setup
# =============================================================================
#
# WHAT THIS DOES:
#   Installs the Fellowship into your project by creating symlinks from
#   claude/{agents,skills,rules,docs} into fellowship/{agents,skills,rules,docs}.
#
# HOW TO RUN:
#   cd fellowship     # or wherever you cloned this repo
#   ./setup.sh                    # Install everything
#   ./setup.sh --no-docs          # Skip fellowship docs
#   ./setup.sh --no-skills        # Skip phase commands (skills)
#   ./setup.sh --agents-only      # Only install agent identities
#
# TO REMOVE:
#   ./uninstall.sh
#
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

print_step()    { echo -e "\n${BLUE}▶ $1${NC}"; }
print_success() { echo -e "${GREEN}  ✓ $1${NC}"; }
print_warning() { echo -e "${YELLOW}  ⚠ $1${NC}"; }
print_skip()    { echo -e "  · $1 (already exists)"; }

# =============================================================================
# PARSE FLAGS
# =============================================================================

INSTALL_AGENTS=true
INSTALL_SKILLS=true
INSTALL_RULES=true
INSTALL_DOCS=true
DRY_RUN=false
CLAUDE_DIR=""

for arg in "$@"; do
    case "$arg" in
        --no-docs)
            INSTALL_DOCS=false
            ;;
        --no-skills)
            INSTALL_SKILLS=false
            ;;
        --no-rules)
            INSTALL_RULES=false
            ;;
        --agents-only)
            INSTALL_SKILLS=false
            INSTALL_RULES=false
            INSTALL_DOCS=false
            ;;
        --dry-run)
            DRY_RUN=true
            ;;
        --claude-dir=*)
            CLAUDE_DIR="${arg#*=}"
            ;;
        --help|-h)
            echo "Usage: ./setup.sh [FLAGS]"
            echo ""
            echo "Flags:"
            echo "  --no-docs      Skip fellowship docs (roster, methodology, handoff protocol, etc.)"
            echo "  --no-skills    Skip phase commands (/spec-and-plan, /build-full-stack, etc.)"
            echo "  --no-rules     Skip fellowship rules (team-operations.md)"
            echo "  --agents-only  Only install agent identities (no skills, rules, or docs)"
            echo "  --dry-run      Show what would be done without making changes"
            echo "  --claude-dir=PATH  Specify the claude/ directory to install into"
            echo "  --help, -h     Show this help message"
            echo ""
            echo "Examples:"
            echo "  ./setup.sh                         # Install everything"
            echo "  ./setup.sh --no-docs               # Agents + skills + rules, no docs"
            echo "  ./setup.sh --agents-only            # Just the 10 agent identities"
            echo "  ./setup.sh --claude-dir=../claude   # Specify target directory"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown flag: $arg${NC}"
            echo "Run with --help for usage."
            exit 1
            ;;
    esac
done

# =============================================================================
# DETECT PATHS
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FELLOWSHIP_DIR="$SCRIPT_DIR"

# Find the claude/ directory
if [[ -n "$CLAUDE_DIR" ]]; then
    # User specified --claude-dir
    CLAUDE_DIR="$(cd "$CLAUDE_DIR" 2>/dev/null && pwd)" || {
        echo -e "${RED}Error: Specified --claude-dir does not exist: $CLAUDE_DIR${NC}"
        exit 1
    }
elif [[ -d "$SCRIPT_DIR/../claude" ]]; then
    # Fellowship is inside a rules repo with claude/ sibling
    CLAUDE_DIR="$(cd "$SCRIPT_DIR/../claude" && pwd)"
elif [[ -d "$SCRIPT_DIR/../../.claude" ]]; then
    # Fellowship is two levels deep, .claude at workspace root
    CLAUDE_DIR="$(cd "$SCRIPT_DIR/../../.claude" && pwd)"
else
    # Default: create claude/ as sibling
    CLAUDE_DIR="$SCRIPT_DIR/../claude"
    echo -e "${YELLOW}No claude/ directory found. Will create at: $CLAUDE_DIR${NC}"
fi

echo ""
echo -e "${BOLD}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║              Fellowship Code - Setup                           ║${NC}"
echo -e "${BOLD}║              It fellowships your code.                          ║${NC}"
echo -e "${BOLD}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Show install mode
if [[ "$DRY_RUN" == true ]]; then
    echo -e "  Mode: ${BOLD}dry-run${NC}"
elif [[ "$INSTALL_SKILLS" == false && "$INSTALL_RULES" == false && "$INSTALL_DOCS" == false ]]; then
    echo -e "  Mode: ${BOLD}agents-only${NC}"
elif [[ "$INSTALL_DOCS" == false ]]; then
    echo -e "  Mode: ${BOLD}no-docs${NC}"
elif [[ "$INSTALL_SKILLS" == false ]]; then
    echo -e "  Mode: ${BOLD}no-skills${NC}"
else
    echo -e "  Mode: ${BOLD}full install${NC}"
fi

echo -e "  Target: ${BOLD}$CLAUDE_DIR${NC}"

if [[ ! -d "$FELLOWSHIP_DIR/agents" ]]; then
    echo -e "${RED}Error: Cannot find agents/ directory in $FELLOWSHIP_DIR${NC}"
    echo "  The fellowship directory appears incomplete."
    exit 1
fi

# =============================================================================
# FELLOWSHIP MANIFEST
# =============================================================================

AGENT_FILES=(
    "gandalf-the-architect.md"
    "aragorn-the-lead-dev.md"
    "legolas-the-frontend-dev.md"
    "gimli-the-backend-dev.md"
    "frodo-the-test-writer.md"
    "samwise-the-qa-dev.md"
    "merry-the-ops-dev.md"
    "pippin-the-specialist-dev.md"
    "boromir-the-code-reviewer.md"
    "smeagol-the-pm.md"
)

SKILL_DIRS=(
    "setup-fellowship"
    "spec-and-plan"
    "build-full-stack"
    "qa-and-polish"
    "code-review"
    "deploy-and-release"
)

RULE_FILES=(
    "team-operations.md"
)

DOC_FILES=(
    "fellowship-roster.md"
    "team-handoff-protocol.md"
    "phase-artifacts.md"
    "planner-methodology.md"
)

# =============================================================================
# HELPER: Create symlink
# =============================================================================

create_symlink() {
    local SOURCE="$1"
    local TARGET="$2"
    local LABEL="$3"

    if [[ "$DRY_RUN" == true ]]; then
        if [[ -L "$TARGET" && -e "$TARGET" ]]; then
            print_skip "$LABEL"
        else
            echo -e "  ${BLUE}[dry-run] would symlink${NC} $LABEL"
        fi
        return
    fi

    if [[ -L "$TARGET" ]]; then
        if [[ -e "$TARGET" ]]; then
            print_skip "$LABEL"
        else
            print_warning "$LABEL is a broken symlink — remove and re-run to fix"
        fi
    elif [[ -e "$TARGET" ]]; then
        print_warning "$LABEL exists and is NOT a symlink — skipping (remove manually to fix)"
    else
        # Use absolute path for the source
        local ABS_SOURCE
        ABS_SOURCE="$(cd "$(dirname "$SOURCE")" 2>/dev/null && pwd)/$(basename "$SOURCE")" 2>/dev/null || ABS_SOURCE="$SOURCE"
        ln -s "$ABS_SOURCE" "$TARGET"
        print_success "$LABEL"
    fi
}

# =============================================================================
# INSTALL
# =============================================================================

print_step "Creating symlinks in $CLAUDE_DIR..."

TOTAL=0
LINKED=0

# --- Agents ---
mkdir -p "$CLAUDE_DIR/agents"
for file in "${AGENT_FILES[@]}"; do
    if [[ -f "$FELLOWSHIP_DIR/agents/$file" ]]; then
        create_symlink "$FELLOWSHIP_DIR/agents/$file" "$CLAUDE_DIR/agents/$file" "agents/$file"
        TOTAL=$((TOTAL + 1))
        [[ -L "$CLAUDE_DIR/agents/$file" ]] && LINKED=$((LINKED + 1))
    else
        print_warning "agents/$file not found — skipping"
    fi
done

# --- Skills ---
if [[ "$INSTALL_SKILLS" == true ]]; then
    mkdir -p "$CLAUDE_DIR/skills"
    for dir in "${SKILL_DIRS[@]}"; do
        if [[ -d "$FELLOWSHIP_DIR/skills/$dir" ]]; then
            create_symlink "$FELLOWSHIP_DIR/skills/$dir" "$CLAUDE_DIR/skills/$dir" "skills/$dir/"
            TOTAL=$((TOTAL + 1))
            [[ -L "$CLAUDE_DIR/skills/$dir" ]] && LINKED=$((LINKED + 1))
        else
            print_warning "skills/$dir/ not found — skipping"
        fi
    done
else
    echo -e "  ${YELLOW}Skipping skills (--no-skills or --agents-only)${NC}"
fi

# --- Rules ---
if [[ "$INSTALL_RULES" == true ]]; then
    mkdir -p "$CLAUDE_DIR/rules"
    for file in "${RULE_FILES[@]}"; do
        if [[ -f "$FELLOWSHIP_DIR/rules/$file" ]]; then
            create_symlink "$FELLOWSHIP_DIR/rules/$file" "$CLAUDE_DIR/rules/$file" "rules/$file"
            TOTAL=$((TOTAL + 1))
            [[ -L "$CLAUDE_DIR/rules/$file" ]] && LINKED=$((LINKED + 1))
        else
            print_warning "rules/$file not found — skipping"
        fi
    done
else
    echo -e "  ${YELLOW}Skipping rules (--no-rules or --agents-only)${NC}"
fi

# --- Docs ---
if [[ "$INSTALL_DOCS" == true ]]; then
    mkdir -p "$CLAUDE_DIR/docs"
    for file in "${DOC_FILES[@]}"; do
        if [[ -f "$FELLOWSHIP_DIR/docs/$file" ]]; then
            create_symlink "$FELLOWSHIP_DIR/docs/$file" "$CLAUDE_DIR/docs/$file" "docs/$file"
            TOTAL=$((TOTAL + 1))
            [[ -L "$CLAUDE_DIR/docs/$file" ]] && LINKED=$((LINKED + 1))
        else
            print_warning "docs/$file not found — skipping"
        fi
    done
else
    echo -e "  ${YELLOW}Skipping docs (--no-docs or --agents-only)${NC}"
fi

# =============================================================================
# SUMMARY
# =============================================================================

MISSING=$((TOTAL - LINKED))

echo ""
echo -e "${BOLD}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║                  Fellowship Assembled!                         ║${NC}"
echo -e "${BOLD}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  Symlinks: $LINKED/$TOTAL created"
if [[ $MISSING -gt 0 ]]; then
    echo -e "  ${YELLOW}Missing: $MISSING (some already existed or sources not found)${NC}"
fi

echo ""
echo -e "${BOLD}Installed components:${NC}"
echo "  Agents:  ${#AGENT_FILES[@]} agent identities"
if [[ "$INSTALL_SKILLS" == true ]]; then
    echo "  Skills:  ${#SKILL_DIRS[@]} phase commands"
else
    echo -e "  Skills:  ${YELLOW}skipped${NC}"
fi
if [[ "$INSTALL_RULES" == true ]]; then
    echo "  Rules:   ${#RULE_FILES[@]} team rules"
else
    echo -e "  Rules:   ${YELLOW}skipped${NC}"
fi
if [[ "$INSTALL_DOCS" == true ]]; then
    echo "  Docs:    ${#DOC_FILES[@]} reference docs"
else
    echo -e "  Docs:    ${YELLOW}skipped${NC}"
fi

if [[ "$INSTALL_SKILLS" == true ]]; then
    echo ""
    echo -e "${BOLD}Available commands:${NC}"
    echo "  /setup-fellowship      Calibrate the team to your project (run this first!)"
    echo "  /spec-and-plan         Specify and plan a feature"
    echo "  /build-full-stack      Implement across repos"
    echo "  /qa-and-polish         QA verification and polish"
    echo "  /code-review           Bidirectional code review"
    echo "  /deploy-and-release    Release to production"
fi

echo ""
if [[ "$DRY_RUN" == true ]]; then
    echo -e "${YELLOW}Dry run complete — no changes made. Remove --dry-run to install.${NC}"
else
    echo -e "${BOLD}To uninstall:${NC}"
    echo "  ./uninstall.sh"
fi
echo ""
echo "  One does not simply ship code without the Fellowship."
echo ""
