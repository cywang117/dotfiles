GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

function print {
    local color=$1
    local to_echo=$2
    case $color in
        g)
            echo -e "${GREEN}${to_echo}${NC}"
            ;;
        r)
            echo -e "${RED}${to_echo}${NC}"
            ;;
        b)
            echo -e "${BLUE}${to_echo}${NC}"
            ;;
        *)
            echo "$to_echo"
            ;;
    esac
}
