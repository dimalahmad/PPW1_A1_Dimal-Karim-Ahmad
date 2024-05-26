function appendInput(value) {
    let display = document.getElementById('display');
    display.value += value;
}

function calculate() {
    let display = document.getElementById('display');
    try {
        let expression = display.value;
        expression = expression.replace(/√/g, 'Math.sqrt');
        expression = expression.replace(/Math\.sin\(([^)]+)\)/g, 'Math.sin($1 * Math.PI / 180)');
        expression = expression.replace(/Math\.cos\(([^)]+)\)/g, 'Math.cos($1 * Math.PI / 180)');
        expression = expression.replace(/Math\.tan\(([^)]+)\)/g, 'Math.tan($1 * Math.PI / 180)');
        expression = expression.replace(/log\(/g, 'Math.log10(');

        let openParentheses = (expression.match(/\(/g) || []).length;
        let closeParentheses = (expression.match(/\)/g) || []).length;
        while (openParentheses > closeParentheses) {
            expression += ')';
            closeParentheses++;
        }
        display.value = new Function('return ' + expression)();
    } catch (error) {
        display.value = 'Error';
    }
}
function deleteLastChar() {
    let display = document.getElementById('display');
    display.value = display.value.slice(0, -1);
}

function clearDisplay() {
    let display = document.getElementById('display');
    display.value = '';
}