window.onload = () => {
    document.querySelector("body").addEventListener("click", handleBodyCapture, true);
    document.querySelector("div").addEventListener("click", handleDivCapture, true);
    document.querySelector("#clickableParagraph").addEventListener("click", handleParagraphCapture, true);
    document.querySelector("#clickableParagraph").addEventListener("click", otherHandleParagraphCapture, true);
}

function handleParagraphClicked() {
    console.log("Paragraph element event handler");
}

function handleDivClicked() {
    console.log("Div element event handler");
}

function handleBodyClicked() {
    console.log("Body element event handler");
}

function handleParagraphCapture(event) {
    console.log("Paragraph element event handler with capturing");
    event.stopImmediatePropagation();
}

function otherHandleParagraphCapture() {
    console.log("Second Paragraph element event handler with capturing");
}

function handleDivCapture() {
    console.log("Div element event handler with capturing");
}

function handleBodyCapture() {
    console.log("Body element event handler with capturing");
}