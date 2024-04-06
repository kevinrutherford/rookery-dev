#! /bin/bash

set -e

API="${1:-http://localhost:44001}"

post() {
  sleep 2
  curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/$1 -d "$2"
}

patch() {
  sleep 2
  curl --fail-with-body -X PATCH -H 'Content-type: application/json' --url ${API}/$1 -d "$2"
}

COLLECTION_1_ID=`uuidgen`
COLLECTION_2_ID=`uuidgen`

post collections '{
  "id": "'$COLLECTION_1_ID'",
  "handle": "chs",
  "name": "CHS",
  "description": "Papers under review by the CHS project"
}'

post collections '{
  "id": "'$COLLECTION_2_ID'",
  "handle": "pru3",
  "name": "PRU3",
  "description": "Papers to be referenced by the PRU3 project"
}'

ENTRY_1_ID=`uuidgen`
ENTRY_2_ID=`uuidgen`
ENTRY_3_ID=`uuidgen`
ENTRY_4_ID=`uuidgen`
ENTRY_5_ID=`uuidgen`

post entries '{
  "id": "'$ENTRY_1_ID'",
  "doi": "10.1126/science.1172133",
  "collectionId": "'$COLLECTION_1_ID'"
}'

post entries '{
  "id": "'$ENTRY_2_ID'",
  "doi": "10.3399/BJGP.2023.0216",
  "collectionId": "'$COLLECTION_1_ID'"
}'

post entries '{
  "id": "'$ENTRY_3_ID'",
  "doi": "10.1111/padm.12268",
  "collectionId": "'$COLLECTION_2_ID'"
}'

post entries '{
  "id": "'$ENTRY_4_ID'",
  "doi": "10.5555/666777",
  "collectionId": "'$COLLECTION_2_ID'"
}'

post comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "I love this!"
}'

post comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "Here is a very long comment, written entirely to test text justification in the browser page for the entry. If you are going to use a passage of Lorem Ipsum, you need to be sure there is nothing embarrassing hidden in the middle of text."
}'

post comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_3_ID'",
  "content": "Not relevant to our needs."
}'

patch works/10.1126/science.1172133 '{
  "data": {
    "type": "work",
    "id": "10.1126/science.1172133",
    "attributes": {
      "crossrefStatus": "found",
      "title": "A General Framework for Analyzing Sustainability of Social-Ecological Systems",
      "abstract": "A major problem worldwide is the potential loss of fisheries, forests, and water resources. Understanding of the processes that lead to improvements in or deterioration of natural resources is limited, because scientific disciplines use different concepts and languages to describe and explain complex social-ecological systems (SESs). Without a common framework to organize findings, isolated knowledge does not cumulate. Until recently, accepted theory has assumed that resource users will never self-organize to maintain their resources and that governments must impose solutions. Research in multiple disciplines, however, has found that some government policies accelerate resource destruction, whereas some resource users have invested their time and energy to achieve sustainability. A general framework is used to identify 10 subsystem variables that affect the likelihood of self-organization in efforts to achieve a sustainable SES.",
      "authors": ["Elinor Ostrom"]
    }
  }
}'

patch works/10.3399/BJGP.2023.0216 '{
  "data": {
    "type": "work",
    "id": "10.3399/BJGP.2023.0216",
    "attributes": {
      "crossrefStatus": "found",
      "title": "Implementing the Additional Roles Reimbursement Scheme in 7 English PCNs: a qualitative study",
      "abstract": "Background: The Additional Roles Reimbursement Scheme (ARRS) provides funding to Primary Care Networks (PCNs) in England to recruit additional staff into specified roles. The intention is to support general practice by recruiting an extra 26,000 staff by 2024, increasing access and easing workload pressures. Aim: To explore the establishment of the ARRS as part of PCNs development to understand their role in supporting general practice. Design and Setting: Longitudinal, qualitative case study involving seven geographically dispersed PCNs across England. Method: Data were collected from July 2020 to March 2022, including 91 semi-structured interviews and 87 hours of meeting observations. Transcripts were analysed using the framework approach. Results: The implementation of the ARRS was variable across the study sites, but most shared similar experiences and concerns. The Covid-19 pandemic had a significant impact on the introduction of the new roles, and we found significant variability in modes of employment. Cross-cutting issues included: the need for additional space to accommodate new staff; the inflexibility of aspects of the scheme, including reinvestment of unspent funds; and the need for support and oversight of employed staff. Perceived benefits of the ARRS include improved patient care and the potential to save GP time. Conclusion: Our findings suggests the ARRS has potential to fulfil its objective of supporting and improving access to general practice. However, attention to operational requirements including appropriate funding, estates and management of staff is important if this is to be realised, as is clarity for the scheme post contract end in 2024.",
      "authors": ["Donna Bramwell", "Jonathan Hammond", "Lynsey Warwick-Giles", "Simon Bailey", "Katherine Checkland"]
    }
  }
}'

patch works/10.5555/666777 '{
  "data": {
    "type": "work",
    "id": "10.5555/666777",
    "attributes": {
      "crossrefStatus": "not-found"
    }
  }
}'

