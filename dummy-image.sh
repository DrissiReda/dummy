
if [[ $# -lt 1 ]]
then
    total=$(ls Dataset/Images/face/ | grep "[^t]$")
else
    total=$@
fi
for var in $total
do
    ./dummy detector test dummy.data faces.cfg faces_final.weights Dataset/Images/face/$var
done
