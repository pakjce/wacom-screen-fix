#!/bin/bash

DISPLAYE_IDS=($(xrandr | grep ' connected' | awk '{print $1}'))
DISPLAYES=$(xrandr | grep ' connected')

echo "$DISPLAYES"
echo "--------------------"
read -p "Please Select display id (0~$((${#DISPLAYE_IDS[@]}-1)))> " display_id

if [[ $display_id -lt 0 || $display_id -ge ${#DISPLAYE_IDS[@]} ]]; then
    echo "Invalid input!"
    exit 1
fi

CURR_DISP=${DISPLAYE_IDS[display_id]}
echo "display_id: $CURR_DISP"

WACOMS=$(xinput | grep -i Wacom  | grep -Eo 'id=[0-9][0-9]')

# echo "${WACOMS}"

for wacom in $WACOMS 
do
    id=$(echo $wacom | tr "id=" " ")
    echo "xinput map-to-output ${id} ${CURR_DISP}"
    xinput map-to-output ${id} ${CURR_DISP}
done
