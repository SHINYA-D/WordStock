//import fs from 'fs/promises'
// #!/usr/bin/env zx

// process は Node.js 環境で提供されるグローバルオブジェクトで、実行中の Node.js プロセスに関する情報や機能を提供します。
// process.env は、プロセスの環境変数にアクセスするためのプロパティです。

//  環境変数の読み取り
const releaseType = process.env.RELEASE_TYPE || 'revision'; // major, minor, revision
const enableAndroid = JSON.parse(process.env.ENABLE_ANDROID) || false;
const enableIOS = JSON.parse(process.env.ENABLE_IOS) || false;

// バージョン設定の読み取り
const readVersionConfig = async (path) => {
  const versionConfig = await fs.readJson(path);
  return versionConfig;
};

// 新しいバージョンの生成
const getNewVersion = (releaseType, versionConfig) => {
  const version = versionConfig.ios.version;
  const versionArray = version.split('.');
  const major = Number(versionArray[0]);
  const minor = Number(versionArray[1]);
  const revision = Number(versionArray[2]);

  let newVersion = '';

  switch (releaseType) {
    case 'major':
      newVersion = `${major + 1}.0.0`;
      break;
    case 'minor':
      newVersion = `${major}.${minor + 1}.0`;
      break;
    case 'revision':
      newVersion = `${major}.${minor}.${revision + 1}`;
      break;
    default:
      newVersion = `${major}.${minor}.${revision + 1}`;
      break;
  }

  return newVersion;
};

//  iOSバージョンの更新
const updateIOSVersion = async (newVersion, versionConfig) => {
  const IOS_EXPO_PATH = 'Expo.plistへのPATH';
  const IOS_PROJECT_PATH = 'project.pbxprojへのPATH';

  await $`sed -i "" 's/v${versionConfig.ios.version}/v${newVersion}/' ${IOS_EXPO_PATH}`;
  await $`sed -i "" 's/MARKETING_VERSION = ${versionConfig.ios.version}/MARKETING_VERSION = ${newVersion}/' ${IOS_PROJECT_PATH}`;

  const newVersionConfig = { ...versionConfig };
  newVersionConfig.ios.version = newVersion;

  return newVersionConfig;
};

// Androidバージョンの更新
const updateAndroidVersion = async (newVersion, versionConfig) => {
  const ANDROID_MANIFEST_PATH = 'AndroidManifest.xmlへのPATH';
  const ANDROID_GRADLE_PATH = 'app/build.gradleへのPATH';

  const prevCode = String(versionConfig.android.code);
  const newCode = String(versionConfig.android.code + 1);

  await $`sed -i "" "s/v${versionConfig.android.version}/v${newVersion}/" ${ANDROID_MANIFEST_PATH}`;
  await $`sed -i "" "s/versionCode ${prevCode}/versionCode ${newCode}/" ${ANDROID_GRADLE_PATH}`;
  await $`sed -i "" "s/"${versionConfig.android.version}"/"${newVersion}"/" ${ANDROID_GRADLE_PATH}`;

  const newVersionConfig = { ...versionConfig };
  newVersionConfig.android.version = newVersion;
  newVersionConfig.android.code = Number(newCode);

  return newVersionConfig;
};

// バージョン設定の保存
const updateVersion = async () => {
  const VERSION_CONFIG_PATH = `version.json`;

  const versionConfig = await readVersionConfig(VERSION_CONFIG_PATH);
  let newVersionConfig = { ...versionConfig };

  const newVersion = getNewVersion(releaseType, versionConfig);

  if (enableIOS) {
    const updatedVersionConfig = await updateIOSVersion(newVersion, versionConfig);
    newVersionConfig = { ...newVersionConfig, ...updatedVersionConfig };
  }

  if (enableAndroid) {
    const updatedVersionConfig = await updateAndroidVersion(newVersion, versionConfig);
    newVersionConfig = { ...newVersionConfig, ...updatedVersionConfig };
  }

  await fs.writeJson(VERSION_CONFIG_PATH, newVersionConfig, { spaces: 2 });
};
updateVersion();