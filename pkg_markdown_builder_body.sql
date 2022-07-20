CREATE OR REPLACE PACKAGE BODY pkg_markdown_builder AS

    PROCEDURE add_heading (
        i_md_doc        IN OUT CLOB
      , i_heading_text  IN VARCHAR2
      , i_heading_level IN NUMBER DEFAULT 1
    ) AS
        v_append_text VARCHAR2(4000);
    BEGIN
        dbms_lob.createtemporary(lob_loc => i_md_doc, cache => true, dur => dbms_lob.call);

        v_append_text := lpad('', 2, '#')
                         || ' '
                         || i_heading_text
                         || c_new_line;

        dbms_lob.writeappend(i_md_doc, length(v_append_text), v_append_text);
    END add_heading;

    PROCEDURE add_heading (
        i_md_doc        IN OUT VARCHAR2
      , i_heading_text  IN VARCHAR2
      , i_heading_level IN NUMBER DEFAULT 1
    ) AS
        v_append_text VARCHAR2(4000);
    BEGIN
        v_append_text := lpad('', 2, '#')
                         || ' '
                         || i_heading_text
                         || c_new_line;

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
        i_md_doc := i_md_doc
                    || i_line_text
                    || c_new_line;
    END add_line;

    PROCEDURE add_table_heading (
        i_md_doc    IN OUT CLOB
      , i_col_names IN t_column_values
    ) AS
        v_append_text       VARCHAR2(4000);
        v_append_text_line1 VARCHAR2(4000);
        v_append_text_line2 VARCHAR2(4000);
    BEGIN
        dbms_lob.createtemporary(lob_loc => i_md_doc, cache => true, dur => dbms_lob.call);

        v_append_text_line1 := '|';
        v_append_text_line2 := '|';
        FOR i IN i_col_names.first..i_col_names.last LOOP
            v_append_text_line1 := v_append_text_line1
                                   || i_col_names(i)
                                   || '|';
            v_append_text_line2 := v_append_text_line2
                                   || lpad('', length(i_col_names(i)), '-')
                                   || '|';

        END LOOP;

        v_append_text := v_append_text_line1
                         || c_new_line
                         || v_append_text_line2;
        dbms_lob.writeappend(i_md_doc, length(v_append_text), v_append_text);
    END add_table_heading;

    PROCEDURE add_table_heading (
        i_md_doc    IN OUT VARCHAR2
      , i_col_names IN t_column_values
    ) AS
        v_append_text       VARCHAR2(4000);
        v_append_text_line1 VARCHAR2(4000);
        v_append_text_line2 VARCHAR2(4000);
    BEGIN
        v_append_text_line1 := '|';
        v_append_text_line2 := '|';
        FOR i IN i_col_names.first..i_col_names.last LOOP
            v_append_text_line1 := v_append_text_line1
                                   || i_col_names(i)
                                   || '|';
            v_append_text_line2 := v_append_text_line2
                                   || lpad('', length(i_col_names(i)), '-')
                                   || '|';

        END LOOP;

        v_append_text := v_append_text_line1
                         || c_new_line
                         || v_append_text_line2
                         || c_new_line;
        i_md_doc := i_md_doc || v_append_text;
    END add_table_heading;

    PROCEDURE add_table_row (
        i_md_doc     IN OUT CLOB
      , i_col_values IN t_column_values
    ) AS
        v_append_text VARCHAR2(4000) := '|';
    BEGIN
        dbms_lob.createtemporary(lob_loc => i_md_doc, cache => true, dur => dbms_lob.call);

        FOR i IN i_col_values.first..i_col_values.last LOOP
            v_append_text := v_append_text
                             || i_col_values(i)
                             || '|';
        END LOOP;

        v_append_text := v_append_text || c_new_line;
        dbms_lob.writeappend(i_md_doc, length(v_append_text), v_append_text);
    END add_table_row;

    PROCEDURE add_table_row (
        i_md_doc     IN OUT VARCHAR2
      , i_col_values IN t_column_values
    ) AS
        v_append_text VARCHAR2(4000) := '|';
    BEGIN
        FOR i IN i_col_values.first..i_col_values.last LOOP
            v_append_text := v_append_text
                             || i_col_values(i)
                             || '|';
        END LOOP;

        v_append_text := v_append_text || c_new_line;
        i_md_doc := i_md_doc || v_append_text;
    END add_table_row;

END pkg_markdown_builder;