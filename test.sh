##### Functions #####
usage() {
    echo "usage: lively-test [-s scheme-name] ([-d device-id] | [-dn device-name]) -c 'commit message'"
}

branchCheck() {
    if [ "$currentBranch" = "develop" ] || [ "$currentBranch" = "master" ]   
    then
        echo "The current branch is '$currentBranch'. Please use another branch to commit."
        exit 1
    fi
}

runUnitTest() {
    xcodebuild -workspace Lively.xcworkspace -scheme $scheme -destination 'platform=iOS,id=$deviceId' test
}

exitIfUnitTestHasError() {
    runUnitTestExitCode=$?
    if [ $runUnitTestExitCode != 0 ]
    then
        echo "Unit test error code '$runUnitTestExitCode'."
        exit $runUnitTestExitCode
    fi
}

commitChanges() {
    echo $commitMessage
    git commit -m "$commitMessage"
    git push -u origin $currentBranch
    runUnitTestExitCode=$?
    if [ $runUnitTestExitCode != 0 ]
    then
        echo "Commit error '$runUnitTestExitCode'."
    else
        echo "Commit success"
    fi
}

##### Main #####

scheme="Lively-Release-QA"
deviceName= 
deviceId=
commitMessage=
currentBranch=$(git branch | grep \* | cut -d ' ' -f2)

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

#echo $scheme
#echo $deviceId
#echo $deviceName
#echo $commitMessage

#branchCheck
#runUnitTest
#exitIfUnitTestHasError
#echo "Si jalo"
commitChanges