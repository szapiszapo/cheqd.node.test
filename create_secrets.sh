#!/bin/bash

for line in $(cat /opt/$PROJECT_NAME/secrets.env); do

  key=$(echo $line | cut -d '=' -f 1)
  value=$(echo $line | cut -d '=' -f 2)

  if [ "$value" == "prompt" ]; then

    while true; do
      read -p "Enter a passphrase for $key:" passphrase
      echo
      read -p "Verify passphrase:" verify
      if [ "$passphrase" == "$verify" ]; then
        # Passphrases match, break loop
        break
      else
        # Passphrases do not match, print a message and continue loop
        echo "Passphrases do not match. Please try again."
      fi
    done

    echo "$passphrase" > passphrase.txt
    value=$(openssl passwd -apr1 -in passphrase.txt)
    rm passphrase.txt
    sed -i "s/$key=prompt/$key=$value/g" /opt/$PROJECT_NAME/secrets.env

    if [ "$key" == "TRAEFIK_HASHED_PASSWORD" ]; then
      echo "The hashed password below will be used to access $key and should be stored."
      echo $value
      echo "Press Enter to acknowledge..."
      read
    fi

  elif [ "$value" == "encrypt" ]; then
    value=$(openssl rand -base64 32)
    sed -i "s/$key=prompt/$key=$value/g" /opt/$PROJECT_NAME/secrets.env
  fi

  # Check if the secret already exists
  if docker secret inspect "$key" &> /dev/null; then
    echo "Secret $key already exists, skipping."
  else
    # Create the secret if it does not exist
    docker secret create "$key" - <<< "$value"
    echo "Secret $key created."
  fi

done




