#!/bin/bash
# VRChat SDK ナレッジベース 定期更新スクリプト
# 使い方: ./update.sh
# または claude でこのスクリプトを呼び出してもらう

KNOWLEDGE_DIR="/home/erenoa6621/dev/vrchat-sdk-knowledge"
DATE=$(date +%Y-%m-%d)

echo "=== VRChat SDK ナレッジベース更新 ==="
echo "日時: $DATE"
echo ""
echo "以下のタスクを実行してください:"
echo ""
echo "1. 公式ドキュメントの更新チェック"
echo "   URL: https://creators.vrchat.com/releases/"
echo "   → SDK更新があればCHANGELOG.mdに記録"
echo "   → 破壊的変更があれば該当ファイルを更新"
echo ""
echo "2. コミュニティTipsの収集"
echo "   - https://zenn.dev/topics/vrchat を検索"
echo "   - https://qiita.com/tags/vrchat を検索"
echo "   - X で '#VRChat制作' '#VRChatアバター' を検索"
echo "   → 新しいTipsを community/ 配下のファイルに追記"
echo ""
echo "3. 各ファイルの最終更新日を更新"
echo "   → 'sed -i' で '最終更新:' 行を $DATE に更新"
echo ""
echo "ナレッジベースパス: $KNOWLEDGE_DIR"
