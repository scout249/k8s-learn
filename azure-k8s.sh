# VARIABLES
SUBSCRIPTION_ID=""
RESOURCE_GROUP="rg-aks-baseline"
LOCATION="northcentralus"
NODE_COUNT=2
CLUSTER_NAME="aks-baseline"
VNET_NAME="vnet-aks-baseline"
SUBNET_NAME="subnet-aks-baseline"
NODE_ADDRESS_SPACE="192.168.0.0/16"
NODE_PREFIX="192.168.1.0/24"
VNET_ADDRESS_SPACE="10.0.0.0/16"
DNS_SERVICE_IP="10.0.0.10"
POD_ADDRESS_SPACE="10.244.0.0/16"
DOCKER_BRIDGE_ADDRESS="172.17.0.1/16"
SYSTEM_NODE_VM_SIZE="Standard_B2s"
SYSTEM_NODE_OS_DISK_SIZE=30

az group create --name $RESOURCE_GROUP --location $LOCATION

az network vnet create \
	--resource-group $RESOURCE_GROUP \
	--name $VNET_NAME \
	--address-prefixes $NODE_ADDRESS_SPACE \
	--subnet-name $SUBNET_NAME \
	--subnet-prefix $NODE_PREFIX

VNET_ID=$(az network vnet show --resource-group $RESOURCE_GROUP --name $VNET_NAME --query id -o tsv)
SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME --query id -o tsv)

az aks create \
	--resource-group $RESOURCE_GROUP \
	--location $LOCATION \
	--name $CLUSTER_NAME \
	--node-count $NODE_COUNT \
	--kubernetes-version 1.22.6 \
	--node-vm-size $SYSTEM_NODE_VM_SIZE \
	--network-plugin kubenet \
	--service-cidr $VNET_ADDRESS_SPACE \
	--dns-service-ip $DNS_SERVICE_IP \
	--pod-cidr $POD_ADDRESS_SPACE \
	--docker-bridge-address $DOCKER_BRIDGE_ADDRESS \
	--vnet-subnet-id $SUBNET_ID \