AKS_STATUS=$(az aks show --name aks-medicine --resource-group rg-aks-medical --query "powerState.code" -o tsv)
 
          if [ "$AKS_STATUS" == "Stopped" ]; then
              echo "AKS cluster is in stopped state. Starting the AKS cluster..."
              az aks start --name  aks-medicine --resource-group rg-aks-medical 
              AKS_STATUS_AFTER_START=$(az aks show --name  aks-medicine --resource-group rg-aks-medical  --query "powerState.code" -o tsv)
              if [ "$AKS_STATUS_AFTER_START" == "Running" ]; then
                  echo "AKS cluster has been successfully started and is now running."
              else
                  echo "Failed to start the AKS cluster. Current status: $AKS_STATUS_AFTER_START"
              fi
          elif [ "$AKS_STATUS" == "Running" ]; then
              echo "AKS cluster is already running."
          else
              echo "AKS cluster is in an unknown state: $AKS_STATUS"
          fi