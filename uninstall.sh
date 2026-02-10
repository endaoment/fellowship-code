#!/bin/bash

# =============================================================================
# Fellowship Code - Uninstall
# =============================================================================
#
# Removes all Fellowship symlinks from claude/{agents,skills,rules,docs}.
# Only removes symlinks whose targets point into the fellowship directory —
# leaves everything else untouched.
#
# FLAGS:
#   --docs-only    Only remove fellowship docs (keep agents, skills, rules)
#   --skills-only  Only remove fellowship skills (keep agents, docs, rules)
#   --keep-agents  Remove everything except agent identities
#
# =============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

print_step()    { echo -e "\n${BLUE}▶ $1${NC}"; }
print_success() { echo -e "${GREEN}  ✓ Removed $1${NC}"; }
print_skip()    { echo -e "  · $1 (not a fellowship symlink)"; }

# =============================================================================
# PARSE FLAGS
# =============================================================================

REMOVE_AGENTS=true
REMOVE_SKILLS=true
REMOVE_RULES=true
REMOVE_DOCS=true
CLAUDE_DIR=""

for arg in "$@"; do
    case "$arg" in
        --docs-only)
            REMOVE_AGENTS=false
            REMOVE_SKILLS=false
            REMOVE_RULES=false
            REMOVE_DOCS=true
            ;;
        --skills-only)
            REMOVE_AGENTS=false
            REMOVE_SKILLS=true
            REMOVE_RULES=false
            REMOVE_DOCS=false
            ;;
        --keep-agents)
            REMOVE_AGENTS=false
            ;;
        --claude-dir=*)
            CLAUDE_DIR="${arg#*=}"
            ;;
        --help|-h)
            echo "Usage: ./uninstall.sh [FLAGS]"
            echo ""
            echo "Flags:"
            echo "  --docs-only       Only remove fellowship docs"
            echo "  --skills-only     Only remove fellowship skills (phase commands)"
            echo "  --keep-agents     Remove everything except agent identities"
            echo "  --claude-dir=PATH Specify the claude/ directory to uninstall from"
            echo "  --help, -h        Show this help message"
            echo ""
            echo "With no flags, removes all fellowship symlinks."
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

if [[ -n "$CLAUDE_DIR" ]]; then
    CLAUDE_DIR="$(cd "$CLAUDE_DIR" 2>/dev/null && pwd)" || {
        echo -e "${RED}Error: Specified --claude-dir does not exist: $CLAUDE_DIR${NC}"
        exit 1
    }
elif [[ -d "$SCRIPT_DIR/../claude" ]]; then
    CLAUDE_DIR="$(cd "$SCRIPT_DIR/../claude" && pwd)"
elif [[ -d "$SCRIPT_DIR/../../.claude" ]]; then
    CLAUDE_DIR="$(cd "$SCRIPT_DIR/../../.claude" && pwd)"
else
    echo -e "${RED}Error: Cannot find claude/ directory. Use --claude-dir=PATH to specify.${NC}"
    exit 1
fi

echo ""
echo -e "${BOLD}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║              Fellowship Code - Uninstall                       ║${NC}"
echo -e "${BOLD}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

REMOVED=0

remove_fellowship_symlinks() {
    local DIR="$1"
    if [[ ! -d "$DIR" ]]; then
        return
    fi
    for item in "$DIR"/*; do
        [[ -e "$item" || -L "$item" ]] || continue
        if [[ -L "$item" ]]; then
            local target
            target=$(readlink "$item")
            if [[ "$target" == *"fellowship"* ]]; then
                rm "$item"
                print_success "$(basename "$DIR")/$(basename "$item")"
                REMOVED=$((REMOVED + 1))
            fi
        fi
    done
}

# =============================================================================
# REMOVE
# =============================================================================

print_step "Removing Fellowship symlinks from $CLAUDE_DIR..."

if [[ "$REMOVE_AGENTS" == true ]]; then
    remove_fellowship_symlinks "$CLAUDE_DIR/agents"
else
    echo -e "  ${YELLOW}Keeping agents${NC}"
fi

if [[ "$REMOVE_SKILLS" == true ]]; then
    remove_fellowship_symlinks "$CLAUDE_DIR/skills"
else
    echo -e "  ${YELLOW}Keeping skills${NC}"
fi

if [[ "$REMOVE_RULES" == true ]]; then
    remove_fellowship_symlinks "$CLAUDE_DIR/rules"
else
    echo -e "  ${YELLOW}Keeping rules${NC}"
fi

if [[ "$REMOVE_DOCS" == true ]]; then
    remove_fellowship_symlinks "$CLAUDE_DIR/docs"
else
    echo -e "  ${YELLOW}Keeping docs${NC}"
fi

# =============================================================================
# SUMMARY
# =============================================================================

echo ""
if [[ $REMOVED -eq 0 ]]; then
    echo "  No Fellowship symlinks found. Already uninstalled?"
else
    echo -e "${GREEN}  Removed $REMOVED symlinks.${NC}"
fi
echo ""
echo "  The fellowship/ directory is untouched."
echo "  To reinstall: ./setup.sh"
echo ""
