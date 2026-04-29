CREATE TABLE cdl_d_party (
  d_party_id INT PRIMARY KEY,
  party_id VARCHAR(255),
  name VARCHAR(255),
  incorporated_country_code VARCHAR(50),
  incorporated_country_name VARCHAR(255),
  da_cpty_class_code VARCHAR(50),
  da_cpty_class_name VARCHAR(255),
  bail_in_type_code VARCHAR(50),
  basel3_cpty_type_code VARCHAR(50),
  tsy_issuer_core_rating_code VARCHAR(50),
  finrep_sector_cd_cpty_code VARCHAR(50)
);

CREATE TABLE cdl_d_reporting_grp (
  d_reporting_grp_id INT PRIMARY KEY,
  code VARCHAR(255),
  name VARCHAR(255),
  reporting_view_code VARCHAR(255),
  reporting_view_name VARCHAR(255)
);

CREATE TABLE cdl_d_party_reporting_grp (
  d_party_reporting_grp_id INT PRIMARY KEY,
  d_reporting_grp_id INT NOT NULL,
  d_party_id INT NOT NULL,
  deleted_by_source_flag VARCHAR(50),
  CONSTRAINT fk_dprg_reporting_grp
    FOREIGN KEY (d_reporting_grp_id) REFERENCES cdl_d_reporting_grp(d_reporting_grp_id),
  CONSTRAINT fk_dprg_party
    FOREIGN KEY (d_party_id) REFERENCES cdl_d_party(d_party_id)
);

CREATE TABLE cdl_d_party_relationship (
  d_party_relationship_id INT PRIMARY KEY,
  from_d_party_id INT NOT NULL,
  to_d_party_id INT NOT NULL,
  d_reporting_grp_id INT NOT NULL,
  relationship_type_code VARCHAR(50),
  relationship_type_name VARCHAR(255),
  internal_flag VARCHAR(50),
  CONSTRAINT fk_rel_from_party
    FOREIGN KEY (from_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_rel_to_party
    FOREIGN KEY (to_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_rel_reporting_grp
    FOREIGN KEY (d_reporting_grp_id) REFERENCES cdl_d_reporting_grp(d_reporting_grp_id)
);

CREATE TABLE cdl_f_consolidated_fact (
  f_consolidated_fact_id INT PRIMARY KEY,
  counterparty_d_party_id INT,
  db_party_d_party_id INT,
  issuer_d_party_id INT,
  guarantor_d_party_id INT,
  parent_d_party_id INT,
  ult_parent_d_party_id INT,
  ifrs_parent_d_party_id INT,
  book_d_party_id INT,
  issuance_reporting_d_party_id INT,
  issuance_proc_recv_d_party_id INT,
  issuance_orig_inv_d_party_id INT,
  db_party_legal_name VARCHAR(255),
  db_party_flag VARCHAR(50),
  CONSTRAINT fk_fact_counterparty
    FOREIGN KEY (counterparty_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_db_party
    FOREIGN KEY (db_party_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_issuer
    FOREIGN KEY (issuer_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_guarantor
    FOREIGN KEY (guarantor_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_parent
    FOREIGN KEY (parent_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_ult_parent
    FOREIGN KEY (ult_parent_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_ifrs_parent
    FOREIGN KEY (ifrs_parent_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_book
    FOREIGN KEY (book_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_issuance_reporting
    FOREIGN KEY (issuance_reporting_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_issuance_proc_recv
    FOREIGN KEY (issuance_proc_recv_d_party_id) REFERENCES cdl_d_party(d_party_id),
  CONSTRAINT fk_fact_issuance_orig_inv
    FOREIGN KEY (issuance_orig_inv_d_party_id) REFERENCES cdl_d_party(d_party_id)
);
