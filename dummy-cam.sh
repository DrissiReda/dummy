
if [[ $# -lt 1 ]]
then
    value=0
else
    value=$1
fi
./dummy detector demo dummy.data faces.cfg faces_final.weights $1

