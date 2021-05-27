#ifndef HHM_CONFIG_H
#define HHM_CONFIG_H

#define HHM_CONFIG_FILE "db.conf"
#define HHM_LOG_FILE    "dm.log"

#define HHM_START_YEAR          2020
#define HHM_DEFAULT_NEWS_TIMER  10000//ms
/*****              DataBase Configs            *****/

#define SERVER_PORT     3306
#define SERVER_USER     "root"
#define SERVER_PASS     "betoche"
#define DATABASE_NAME   "hhm_db"

#define HHM_DOC_STATUS_SUCCESS 1
#define HHM_DOC_STATUS_PENDING 2
#define HHM_DOC_STATUS_REJECT  3

//Tables
#define HHM_TABLE_CONFIG       "config"
#define HHM_TABLE_USER         "user"
#define HHM_TABLE_EMAIL        "email"
#define HHM_TABLE_DOCUMENT     "document"
#define HHM_TABLE_USER_EMAIL   "user_email"
#define HHM_TABLE_NEWS         "news"

//Columns in Table `HHM_TABLE_CONFIG`
#define HHM_CONFIG_KEY          "config_key"
#define HHM_CONFIG_VALUE        "config_value"

//Keys for column `HHM_CONFIG_KEY` in Table `HHM_TABLE_CONFIG`
#define HHM_CONFIG_FTP_SERVER          "ftp_server"
#define HHM_CONFIG_FTP_USERNAME        "ftp_username"
#define HHM_CONFIG_FTP_PASSWORD        "ftp_password"
#define HHM_CONFIG_DOMAIN              "domain"
#define HHM_CONFIG_DOCUMENT_BASE_ID    "doc_base_id"
#define HHM_CONFIG_NEWS_TIMER          "news_timer"

//Columns in Table `HHM_TABLE_USER`
#define HHM_USER_ID             "id"
#define HHM_USER_FIRSTNAME      "firstname"
#define HHM_USER_LASTNAME       "lastname"
#define HHM_USER_USERNAME       "username"
#define HHM_USER_LASTLOGIN      "lastlogin"
#define HHM_USER_STATUS         "status"
#define HHM_USER_BIO            "bio"
#define HHM_USER_IMAGE          "image"
#define HHM_USER_PASSWORD       "password"

//Columns in Table `HHM_TABLE_EMAIL`
#define HHM_EMAIL_ID                   "id"
#define HHM_EMAIL_DOC_CASENUMBER       "d_case_number"
#define HHM_EMAIL_FLAG                 "flag"
#define HHM_EMAIL_OPENED               "opened"
#define HHM_EMAIL_OPEN_TIME            "open_time"
#define HHM_EMAIL_SEND_REFERENCE       "s_email"
#define HHM_EMAIL_RECEIVE_REFERENCE    "r_email"

//Columns in Table 'HHM_TABLE_DOCUMENT'
//#define HHM_DOCUMENTS_ID                "id"
#define HHM_DOCUMENT_CASENUMBER        "case_num"
#define HHM_DOCUMENT_SENDER_ID         "s_id"
#define HHM_DOCUMENT_RECEIVER_IDS      "r_ids"
#define HHM_DOCUMENT_DATE              "date"
#define HHM_DOCUMENT_SENDER_NAME       "s_name"
#define HHM_DOCUMENT_FILEPATH          "filepath"
#define HHM_DOCUMENT_STATUS            "status"
#define HHM_DOCUMENT_SUBJECT           "subject"

//Columns in Table `HHM_TABLE_USER_EMAIL`
#define HHM_UE_ID                   "id"
#define HHM_UE_USER_ID              "user_id"
#define HHM_UE_DATE                 "date"
#define HHM_UE_SENT_EMAILS          "sent_emails"
#define HHM_UE_RECEIVED_EMAILS      "received_emails"

//Columns in Table `HHM_TABLE_NEWS`
#define HHM_NEWS_ID                 "id"
#define HHM_NEWS_TITLE              "title"
#define HHM_NEWS_CONTENT            "content"
#define HHM_NEWS_DATE               "date"

#endif // HHM_CONFIG_H
