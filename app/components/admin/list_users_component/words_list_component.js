class ListUsers extends HTMLElement {
  constructor() {
    super();
    this.shadow = this.attachShadow({ mode: "open" });
    this.shadow.adoptedStyleSheets = [...document.adoptedStyleSheets];
  }
  connectedCallback() {
    const template = $(this.getRootNode())
      .find("#users-list-template")
      .prop("content");
    this.shadow.appendChild(template);
    $(this.shadow).find("#users-list-table").DataTable();
  }
}

customElements.define("users-list", ListUsers);
