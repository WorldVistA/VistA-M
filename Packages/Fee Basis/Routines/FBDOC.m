FBDOC ;ALBISC\TET - ROUTINE DOCUMENTATION ;10/9/92  11:24
 ;;3.5;FEE BASIS;**48**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Routine contains documentation of other routines.  Name sets
 ;  of routines are indicated in line label.
FBPCR ;
 ;POTENTIAL COST RECOVERY REPORT
 ;user selects primary service areas and date range.
 ;The user is able to filter data to include Copays or Insurance only
 ;related information:
 ;   Include (P)atient Co-pays / (I)nsurance / (B)oth
 ;If the user selects (P) or (B),the following prompt will allow 
 ;the user to include Mean Test or LTC copays only or Both:
 ;   Include (M)eans Test Co-pays /(L)TC Co-pays /(B)oth
 ;output will sort by primary service area, patient, program, vendor, date.
 ;only those that are means test category c/agree to pay deductible
 ;  or for non-service connected treatment are printed, as well as
 ;  insurance information.
 ;Since 7/5/2002 all LTC related payments are flagged in the report with 
 ;appropriate messages. If the veteran doesn't have LTC test on file then
 ;the LTC related payment is flagged with "1010EC missing" message.
 ;
 ;outpatient info - program 2 - fbpcr2 uses date finalized for date range sort
 ;      o for each service on a treatment date the value of the
 ;        'service connected y/n' field is checked.
 ;        if no, flag to collect from insurance is set.
 ;      o for the INITIAL TREATMENT DATE, checks if patient was cat c 
 ;        and agreed to pay deductible or was not exempt from LTC copay.
 ;        if true, then software uses IB call to determine if patient
 ;        is insured on treatment date
 ;       o if service is for C&P, or both of the above two flags are 
 ;         negative, record is bypassed.
 ;pharmacy info - program 3 - fbpcr3 uses date certified for payment for date range sort
 ;       o for each invoice number, RX number for a patient within the
 ;         specified date range, the value of the rx fill date field is
 ;         obtained and checked against the authorization in the fee 
 ;         patient file.  a check is made to see if the value of the
 ;         potential cost recovery field is yes for an authorization
 ;         which encompasses the fill date.
 ;         if yes, then software uses IB call to determine if patient
 ;         is insured on date certified for payment
 ;       o for date certified for payment, checks if patient was cat c
 ;         and agreed to pay deductible. if true, flag to collect from
 ;         patient is set.
 ;       o if both of the above two flags are negative, record is bypassed.
 ;ch/cnh info - programs 6 and 7 - fbpcr67* uses date finalized for date range sort
 ;       o for each record, for a patient within the specified date
 ;         range, the value of the treatment from date is obtained
 ;         and checked against the authorization in the fee patient file.
 ;         a check is made to see if the value of the potential cost
 ;         recovery field is yes for an authorization which encompasses
 ;         the treatment from date.
 ;         if yes, then software uses IB call to determine if patient
 ;         is insured on date certified for payment.
 ;       o for TREATMENT FROM DATE and TREATMENT TO DATE, checks if 
 ;         patient was cat c and agreed to pay deductible or was not 
 ;         exempt from LTC copay. if true, flag to collect from patient
 ;         is set.
 ;       o if both of the above two flags are negative, record is bypassed.
