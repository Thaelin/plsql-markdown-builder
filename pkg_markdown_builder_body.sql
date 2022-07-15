create or replace PACKAGE BODY pkg_markdown_builder AS

    PROCEDURE add_heading (
        i_md_doc        IN OUT CLOB
      , i_heading_text  IN VARCHAR2
      , i_heading_level IN NUMBER DEFAULT 1
    ) AS
        v_append_text VARCHAR2(4000);
    BEGIN
        dbms_lob.createtemporary(lob_loc => i_md_doc, cache => true, dur => dbms_lob.call);
        v_append_text := '';
        for i in 1..i_heading_level loop
            v_append_text := v_append_text || '#';
        end loop;
        v_append_text := v_append_text || ' ' || i_heading_text || c_new_line;
        dbms_lob.writeappend(i_md_doc, length(v_append_text), v_append_text);
    END add_heading;

    PROCEDURE add_heading (
        i_md_doc        IN OUT VARCHAR2
      , i_heading_text  IN VARCHAR2
      , i_heading_level IN NUMBER DEFAULT 1
    ) AS
        v_append_text VARCHAR2(4000);
    BEGIN
        v_append_text := '';
        for i in 1..i_heading_level loop
            v_append_text := v_append_text || '#';
        end loop;
        v_append_text := v_append_text || ' ' || i_heading_text || c_new_line;
        i_md_doc := i_md_doc || v_append_text;
    END add_heading;

    PROCEDURE add_line (
        i_md_doc    IN OUT CLOB
      , i_line_text IN VARCHAR2
    ) AS
        v_append_text VARCHAR2(4000);
    BEGIN
        dbms_lob.createtemporary(lob_loc => i_md_doc, cache => true, dur => dbms_lob.call);
        v_append_text := i_line_text || c_new_line;
        dbms_lob.writeappend(i_md_doc, length(v_append_text), v_append_text);
    END add_line;

    PROCEDURE add_line (
        i_md_doc    IN OUT VARCHAR2
      , i_line_text IN VARCHAR2
    ) AS
    BEGIN
        i_md_doc := i_md_doc || i_line_text || c_new_line;
    END add_line;

    PROCEDURE add_table_heading (
        i_md_doc    IN CLOB
      , i_col_names IN t_column_values
    ) AS
    BEGIN
    -- TODO: Implementation required for PROCEDURE PKG_MARKDOWN_BUILDER.add_table_heading
        NULL;
    END add_table_heading;

    PROCEDURE add_table_heading (
        i_md_doc    IN VARCHAR2
      , i_col_names IN t_column_values
    ) AS
    BEGIN
    -- TODO: Implementation required for PROCEDURE PKG_MARKDOWN_BUILDER.add_table_heading
        NULL;
    END add_table_heading;

    PROCEDURE add_table_row (
        i_md_doc     IN CLOB
      , i_col_values IN t_column_values
    ) AS
    BEGIN
    -- TODO: Implementation required for PROCEDURE PKG_MARKDOWN_BUILDER.add_table_row
        NULL;
    END add_table_row;

    PROCEDURE add_table_row (
        i_md_doc     IN VARCHAR2
      , i_col_values IN t_column_values
    ) AS
    BEGIN
    -- TODO: Implementation required for PROCEDURE PKG_MARKDOWN_BUILDER.add_table_row
        NULL;
    END add_table_row;

END pkg_markdown_builder;