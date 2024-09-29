AKS_STATUS=$(az aks show --name aks-medicine --resource-group rg-aks-medical --query "powerState.code" -o tsv)

if [ "$AKS_STATUS" == "Running" ]; then
    echo "AKS cluster is in Running state. Stoping the AKS cluster..."
    az aks stop --name aks-medicine --resource-group rg-aks-medical
                
    AKS_STATUS_AFTER_STOP=$(az aks show --name aks-medicine --resource-group rg-aks-medical --query "powerState.code" -o tsv)
    if [ "$AKS_STATUS_AFTER_STOP" == "Stopped" ]; then
        echo "AKS cluster has been successfully Stopped."
    else
        echo "Failed to start the AKS cluster. Current status: $AKS_STATUS_AFTER_START"
    fi
elif [ "$AKS_STATUS" == "Stopped" ]; then
    echo "AKS cluster is already Stopped."
else
    echo "AKS cluster is in an unknown state: $AKS_STATUS"
fi