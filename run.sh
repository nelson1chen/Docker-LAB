#!/bin/bash

# 一個管理 Docker Compose 實驗環境的簡單腳本

# 顯示幫助訊息
show_help() {
    echo "Usage: $0 {up|down|logs|ps|restart}"
    echo "Commands:"
    echo "  up       - 啟動所有服務 (背景執行)"
    echo "  down     - 停止並移除所有服務、網路和資料卷"
    echo "  logs [服務名] - 查看日誌。如果指定服務名，則只看該服務的日誌"
    echo "  ps       - 列出此專案正在執行的容器"
    echo "  restart  - 重啟所有服務"
}

# 檢查 docker 和 docker compose 插件是否已安裝
# 我們透過執行 `docker compose version` 來確認插件是否存在
if ! command -v docker &> /dev/null || ! docker compose version &> /dev/null; then
    echo "錯誤: 找不到 'docker' 命令或 'docker compose' 插件。"
    echo "請確保您已在 WSL2 中安裝並啟動 Docker Desktop，且 Compose V2 插件已啟用。"
    exit 1
fi

# 主邏輯
case "$1" in
    up)
        echo "正在啟動所有服務..."
        docker compose up -d
        ;;
    down)
        echo "正在停止並移除所有服務..."
        docker compose down -v
        ;;
    logs)
        echo "正在追蹤日誌... (按 Ctrl+C 停止)"
        docker compose logs -f "$2"
        ;;
    ps)
        docker compose ps
        ;;
    restart)
        echo "正在重啟所有服務..."
        docker compose restart
        ;;
    *)
        show_help
        exit 1
        ;;
esac

exit 0