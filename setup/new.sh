# Run this script with sudo after the creation of a new codespace with
# sudo bash -x new.sh

# if [ $(id -u) -ne 0 ]
# then
#   echo "ERROR: This script must be run with sudo"
#   echo "       sudo bash -x $(basename '$0')"
#   exit
# fi

# START_DIR=$PWD                  # remember starting directory
# apt update                      # update apt repository information
# apt install default-jdk -y      # install jdk
# apt install android-sdk -y      # install Android sdk
# cd /usr/lib/android-sdk         # change into Android sdk directory
#                                 # then download cmdline_tools
# curl -o cli_tools.zip https://bdavison.napier.ac.uk/set09102/setup/commandlinetools-linux-11076708_latest.zip
# unzip -o cli_tools.zip          # Unzip cmdline_tools (including sdkmanager)
# cd cmdline-tools/bin            # change into cmdline_tools directory
#                                 # then update Android platforms to latest
# echo y | ./sdkmanager --update --sdk_root=/usr/lib/android-sdk/
# cd ${START_DIR}/Haulage         # change into project root directory
cd Haulage
sudo dotnet workload restore      # restore MAUI workloads
                                  # install android dependencies. Env vars are set in devcontainer.json
dotnet build -t:InstallAndroidDependencies -f:net8.0-android -p:AndroidSdkDirectory="${ANDROID_HOME}" -p:JavaSdkDirectory="${JAVA_HOME}" -p:AcceptAndroidSDKLicenses=True
dotnet restore                  # restore project
${ANDROID_HOME}/cmdline-tools/11.0/bin/sdkmanager --install  "emulator"
echo y | ${ANDROID_HOME}/cmdline-tools/11.0/bin/sdkmanager --install  "system-images;android-34;google_apis;x86_64"
${ANDROID_HOME}/cmdline-tools/11.0/bin/avdmanager create avd -d 30 --name Pixel_7_Pro -k "system-images;android-34;google_apis;x86_64"
echo Done                       # report end of script
