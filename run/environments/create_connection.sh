while getopts a:n:w: flag
do
    case "${flag}" in
        a) admin_pwd=${OPTARG};;
        n) db_name=${OPTARG};;
        w) wallet_pwd=${OPTARG};;
        *) echo "Usage: $0 -a Admin Password -w WalletPassword -n Database Name"; exit 1;
    esac
done

echo "Datbase Name: ${db_name:?Missing -n} 

ACCEPT pod_name     CHAR PROMPT 'Enter the name of the Pod:'


!podman cp ${pod_name}:/u01/app/oracle/wallets/tls_wallet /${pod_name}/tls_wallet
