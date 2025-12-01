#!/bin/bash

# HarmonyOS 环境配置脚本
# 用于配置 hdc、ohpm、hvigor 等工具的环境变量

echo "========================================="
echo "HarmonyOS 环境配置脚本"
echo "========================================="
echo ""

# 常见的 HarmonyOS/OpenHarmony SDK 安装路径
POSSIBLE_PATHS=(
    "$HOME/Library/OpenHarmony/Sdk"
    "$HOME/Library/Huawei/Sdk"
    "$HOME/Huawei/Sdk"
    "/Applications/DevEco Studio.app/Contents/sdk"
    "$HOME/.local/share/Huawei/Sdk"
)

HDC_PATH=""
OHPM_PATH=""
HVIGOR_PATH=""

# 查找 hdc
echo "正在查找 hdc 工具..."
# 先检查是否已在 PATH 中
if command -v hdc &> /dev/null; then
    HDC_PATH=$(dirname $(which hdc))
    echo "✅ 找到 hdc (已在 PATH 中): $(which hdc)"
else
    for base_path in "${POSSIBLE_PATHS[@]}"; do
        if [ -d "$base_path" ]; then
            # 查找 toolchains 目录下的 hdc
            hdc_candidate=$(find "$base_path" -name "hdc" -type f 2>/dev/null | head -1)
            if [ -n "$hdc_candidate" ]; then
                HDC_PATH=$(dirname "$hdc_candidate")
                echo "✅ 找到 hdc: $hdc_candidate"
                break
            fi
        fi
    done
fi

# 查找 ohpm
echo "正在查找 ohpm 工具..."
if command -v ohpm &> /dev/null; then
    OHPM_PATH=$(dirname $(which ohpm))
    echo "✅ 找到 ohpm: $(which ohpm)"
else
    for base_path in "${POSSIBLE_PATHS[@]}"; do
        if [ -d "$base_path" ]; then
            ohpm_candidate=$(find "$base_path" -name "ohpm" -type f 2>/dev/null | head -1)
            if [ -n "$ohpm_candidate" ]; then
                OHPM_PATH=$(dirname "$ohpm_candidate")
                echo "✅ 找到 ohpm: $ohpm_candidate"
                break
            fi
        fi
    done
fi

# 查找 hvigor
echo "正在查找 hvigor 工具..."
if command -v hvigor &> /dev/null; then
    HVIGOR_PATH=$(dirname $(which hvigor))
    echo "✅ 找到 hvigor: $(which hvigor)"
else
    for base_path in "${POSSIBLE_PATHS[@]}"; do
        if [ -d "$base_path" ]; then
            hvigor_candidate=$(find "$base_path" -name "hvigor" -type f 2>/dev/null | head -1)
            if [ -n "$hvigor_candidate" ]; then
                HVIGOR_PATH=$(dirname "$hvigor_candidate")
                echo "✅ 找到 hvigor: $hvigor_candidate"
                break
            fi
        fi
    done
fi

echo ""
echo "========================================="
if [ -z "$HDC_PATH" ]; then
    echo "❌ 未找到 hdc 工具"
    echo ""
    echo "请按照以下步骤操作："
    echo "1. 安装 OpenHarmony SDK 或 HarmonyOS SDK"
    echo "   - OpenHarmony: https://gitee.com/openharmony/docs"
    echo "   - HarmonyOS DevEco Studio: https://developer.harmonyos.com/cn/develop/deveco-studio"
    echo ""
    echo "2. 配置环境变量（编辑 ~/.zshrc）："
    echo ""
    echo "   # OpenHarmony SDK"
    echo "   export OPENHARMONY_SDK=\$HOME/Library/OpenHarmony/Sdk"
    echo "   export PATH=\$OPENHARMONY_SDK/20/toolchains:\$PATH"
    echo ""
    echo "   或"
    echo ""
    echo "   # HarmonyOS SDK"
    echo "   export HARMONYOS_SDK=\$HOME/Library/Huawei/Sdk"
    echo "   export PATH=\$HARMONYOS_SDK/toolchains:\$PATH"
    echo ""
    echo "3. 运行: source ~/.zshrc"
else
    echo "环境变量配置建议："
    echo ""
    echo "请将以下内容添加到 ~/.zshrc 文件中："
    echo ""
    
    if [ -n "$HDC_PATH" ]; then
        echo "export PATH=\"$HDC_PATH:\$PATH\""
    fi
    
    if [ -n "$OHPM_PATH" ] && [ "$OHPM_PATH" != "$HDC_PATH" ]; then
        echo "export PATH=\"$OHPM_PATH:\$PATH\""
    fi
    
    if [ -n "$HVIGOR_PATH" ] && [ "$HVIGOR_PATH" != "$HDC_PATH" ] && [ "$HVIGOR_PATH" != "$OHPM_PATH" ]; then
        echo "export PATH=\"$HVIGOR_PATH:\$PATH\""
    fi
    
    echo ""
    # 判断是 OpenHarmony 还是 HarmonyOS
    if [[ "$HDC_PATH" == *"OpenHarmony"* ]]; then
        SDK_BASE=$(dirname "$HDC_PATH" 2>/dev/null)
        echo "检测到 OpenHarmony SDK，建议配置："
        echo "export OPENHARMONY_SDK=\"$SDK_BASE\""
        echo "export PATH=\"\$OPENHARMONY_SDK/20/toolchains:\$PATH\""
    else
        SDK_BASE=$(dirname "$HDC_PATH" 2>/dev/null || echo "$HOME/Library/Huawei/Sdk")
        echo "检测到 HarmonyOS SDK，建议配置："
        echo "export HARMONYOS_SDK=\"$SDK_BASE\""
        echo "export PATH=\"\$HARMONYOS_SDK/toolchains:\$PATH\""
        echo "export PATH=\"\$HARMONYOS_SDK/ohpm:\$PATH\""
    fi
    echo ""
    echo "配置完成后，运行: source ~/.zshrc"
fi
echo "========================================="

