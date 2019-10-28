##### Functions #####
usage() {
    echo "usage: lively-test [-s scheme-name] ([-d device-id] | [-dn device-name]) -c 'commit message'"
}

branchCheck() {
    currentBranch=$(git branch | grep \* | cut -d ' ' -f2)
    echo $currentBranch
    if [ "$currentBranch" = "developa" ]   
    then
        exit 99
    fi
}
##### Main #####

scheme="Lively-Release-QA"
deviceName= 
deviceId=
commitMessage=

while [ "$1" != "" ]; do
    case $1 in
        -s | --scheme ) shift
                                scheme=$1
                                ;;
        -d | --deviceId ) shift
                                deviceId=$1
                                ;;
        -dn | --deviceName ) shift
                                deviceName=$1
                                ;;
        -c | --commitMessage ) shift
                                commitMessage=$1
                                ;;
                                
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

echo $scheme
echo $deviceId
echo $deviceName
echo $commitMessage

branchCheck