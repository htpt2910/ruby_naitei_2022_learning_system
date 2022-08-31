class WordsList extends HTMLElement {
  constructor() {
    super();
    this.shadow = this.attachShadow({ mode: "open" });
    this.shadow.adoptedStyleSheets = [...document.adoptedStyleSheets];
  }
  connectedCallback() {
    const template = $(this.getRootNode())
      .find("#words-list-template")
      .prop("content");
    this.shadow.appendChild(template);
    this.initHeaderFooter();
    this.initTable();
  }
  initHeaderFooter() {
    const table = $(this.shadow).find("table");
    const thead = $("<thead>");
    const tfoot = $("<tfoot>");
    const headers = JSON.parse($(this).attr("headers"));
    const tr = $("<tr>");
    headers.forEach((header) => {
      const th = $("<th>");
      th.text(header);
      tr.append(th);
    });
    thead.append(tr);
    tfoot.append(tr.clone());
    table.append(thead);
    table.append(tfoot);
  }
  initTable() {
    const table = $(this.shadow).find("table");
    const columns = JSON.parse($(this).attr("columns"));
    const headers = JSON.parse($(this).attr("headers"));
    let columnsAttributes = columns.map((column) => ({
      data: column,
    }));
    const columnDefs = [];

    if (columns[columns.length - 1] === "delete") {
      columnsAttributes.pop();
      columnsAttributes.push({
        data: null,
        defaultContent: `<a class='btn btn-outline-secondary'>${
          headers[headers.length - 1]
        }</a>`,
        orderable: false,
      });
    } else if (columns[columns.length - 1] === "done") {
      columnsAttributes.pop();
      columnsAttributes.push({
        data: null,
        defaultContent: `<input type='checkbox' class='form-check-input'>`,
        orderable: false,
      });
      columnDefs.push({
        targets: -1,
        render: function (data) {
          return `<input type='checkbox' class='form-check-input' ${
            data.user_learn_words_id ? "checked" : ""
          }>`;
        },
      });
    }

    const dataTable = table.DataTable({
      ajax: { url: $(this).attr("data-url"), dataSrc: "" },
      columns: columnsAttributes,
      columnDefs: columnDefs,
    });
    this.dataTable = dataTable;
    const confirmMessage = $(this).attr("data-confirm-message");
    $(this.shadow)
      .find("table tbody")
      .on("click", "a", function () {
        if (confirm(confirmMessage)) {
          const data = dataTable.row($(this).parents("tr")).data();
          $.ajax({
            url: "/admin/words/" + data.id,
            type: "DELETE",
            dataType: "json",
            success: (response) => {
              dataTable.row($(this).parents("tr")).remove().draw();
              toastr.success(response.message);
            },
            error: (response) => {
              toastr.error(response.message);
            },
          });
        }
      });
    $(this.shadow)
      .find("table tbody")
      .on("change", "input", function () {
        const checkBox = $(this);
        const data = dataTable.row(checkBox.parents("tr")).data();
        const wordSlide = $(`[data-word-id=${data.id}]`);
        if (checkBox.is(":checked")) {
          $.ajax({
            url: "/user_learn_words",
            type: "POST",
            dataType: "json",
            data: {
              word_id: data.id,
            },
            success: (response) => {
              checkBox.prop("checked", true);
              wordSlide.prop("checked", true);
              wordSlide.attr("data-user-learn-word-id", response.data.id);
              const newData = {
                ...data,
                user_learn_words_id: response.data.id,
              };
              dataTable.row(checkBox.parents("tr")).data(newData).draw();
            },
            error: (response) => {
              toastr.error(response.message);
              checkBox.prop("checked", false);
            },
          });
        } else {
          $.ajax({
            url: "/user_learn_words/" + data.user_learn_words_id,
            type: "DELETE",
            dataType: "json",
            success: (response) => {
              checkBox.prop("checked", false);
              wordSlide.prop("checked", false);
            },
            error: (response) => {
              toastr.error(response.message);
              checkBox.prop("checked", true);
            },
          });
        }
      });
  }
}

customElements.define("words-list", WordsList);
