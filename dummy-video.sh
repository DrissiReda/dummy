
if [[ $# -lt 1 ]]
then
    echo " You need to give some input"
else
    ./dummy detector demo dummy.data faces.cfg faces_final.weights $1
fi
