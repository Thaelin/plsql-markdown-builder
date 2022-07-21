CREATE OR REPLACE PACKAGE pkg_markdown_builder AS
    /**
        Author: Jakub Hubert
        Description: Slúži na zjednodušenie práce s markdown dokumentami. Podporuje dátové typy LOB aj VARCHAR2.
        Date: 15. 07. 2022
    **/
    c_new_line VARCHAR2(2 BYTE) := chr(13)
                                   || chr(10);
    TYPE t_column_values IS
        TABLE OF VARCHAR2(4000);
        
    /* HEADING */
    PROCEDURE add_heading (
        i_md_doc        IN OUT NOCOPY CLOB
      , i_heading_text  IN VARCHAR2
      , i_heading_level IN NUMBER DEFAULT 1
    );

    PROCEDURE add_heading (
        i_md_doc        IN OUT VARCHAR2
      , i_heading_text  IN VARCHAR2
      , i_heading_level IN NUMBER DEFAULT 1
    );

    /* LINE */
    PROCEDURE add_line (
        i_md_doc    IN OUT NOCOPY CLOB
      , i_line_text IN VARCHAR2
    );

    PROCEDURE add_line (
        i_md_doc    IN OUT VARCHAR2
      , i_line_text IN VARCHAR2
    );

    /* TABLE HEADING */
    PROCEDURE add_table_heading (
        i_md_doc    IN OUT NOCOPY CLOB
      , i_col_names IN t_column_values
    );

    PROCEDURE add_table_heading (
        i_md_doc    IN OUT VARCHAR2
      , i_col_names IN t_column_values
    );
    
    /* TABLE ROW */
    PROCEDURE add_table_row (
        i_md_doc    IN OUT NOCOPY CLOB
      , i_col_values IN t_column_values
    );

    PROCEDURE add_table_row (
        i_md_doc    IN OUT VARCHAR2
      , i_col_values IN t_column_values
    );
    
    FUNCTION markdown_escape(i_text IN VARCHAR2) RETURN VARCHAR2 ;

END pkg_markdown_builder;