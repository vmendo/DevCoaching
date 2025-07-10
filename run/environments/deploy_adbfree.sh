while getopts a:n:w: flag
do
    case "${flag}" in
        a) admin_pwd=${OPTARG};;
        n) db_name=${OPTARG};;
        w) wallet_pwd=${OPTARG};;
        *) echo "Usage: $0 -a Admin Password -w WalletPassword -n Database Name"; exit 1;
    esac
done

echo "Datbase Name: ${db_name:?Missing -n} Admin Password: ${admin_pwd:?Missing -a} Wallet Password: ${wallet_pwd:?Missing -w}"
echo "Deploying Podman instance: $db_name";

podman -v

<<COMMENT
podman run -d \
-p 1521:1522 \
-p 1522:1522 \
-p 8443:8443 \
-p 27017:27017 \
-e WORKLOAD_TYPE=ATP \
-e WALLET_PASSWORD=$wallet_pwd \
-e ADMIN_PASSWORD=$admin_pwd \
--cap-add SYS_ADMIN \
--device /dev/fuse \
--name $name \
--volume adb_vol_01:/u01/data \
container-registry.oracle.com/database/adb-free:latest-23ai

-- Start the Pod
echo "To start the Pod if not started"
echo "podman start $name"

echo "Current Status of the Pod"
podman ps -a -f name=$name

echo "Pod Logs"
podman logs $name
COMMENT