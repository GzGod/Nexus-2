### 一键脚本
```bash
wget -O test.sh https://raw.githubusercontent.com/GzGod/Nexus-2/refs/heads/main/test.sh && sed -i 's/\r$//' test.sh && chmod +x test.sh && ./test.sh
```
### 网页自动重连指令
```bash
/**
 * 使用XPath表达式获取元素的值。
 * @param {string} xpath - 用来定位元素的XPath。
 * @return {Node|null} 返回找到的元素节点，如果未找到则返回null。
 */
function getElementByXPath(xpath) {
    const result = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null);
    return result.singleNodeValue;
}

/**
 * 根据页面内容处理连接到Nexus的操作。
 */
function connectToNexus() {
    const textElement = getElementByXPath('/html/body/div[3]/div[2]/main/main/div[2]/div/div/div[1]/div[2]/div/div/p');
    
    if (textElement) {
        const textContent = textElement.textContent;
        console.log(`找到的文本: ${textContent}`);
        
        if (textContent === "CONNECT TO NEXUS") {
            const button = getElementByXPath("/html/body/div[3]/div[2]/main/main/div[2]/div/div/div[1]/div[1]/div/div/div/div/div[2]");
            if (button) {
                button.click();
            } else {
                console.log("未找到连接按钮。");
            }
        } else {
            console.log("现在还不是连接时间。");
        }
    } else {
        console.log("未找到所需的文本元素。");
    }
}

// 首次检查在5秒后执行
setTimeout(connectToNexus, 5000);

// 每隔5秒进行一次后续检查
setInterval(connectToNexus, 5000);
```
