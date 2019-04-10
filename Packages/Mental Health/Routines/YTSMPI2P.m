YTSMPI2P ;SLC/PIJ - Score MMPI-2-RF ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
PROGNOTE ;
 N DASHES,VSCALE,SCRS,FNOTE
 S VSCALE=0
 S FNOTE="|The highest and lowest T scores possible on each scale are indicated by a ""---"";|"
 S FNOTE=FNOTE_"T scores are non-gendered.|"
 S FNOTE=FNOTE_"|Scales marked with an asterisk have response percentages below 90%."
 S $P(DASHES,"_",80)="_"
 ;
 ;-------------- Validity Checks  --------------
 ;Cannot Say
 I CNT("cannotSay")>18 D
 .S TXT=TXT_"|INVALID RESULTS"
 .S TXT=TXT_"|There are too many 'Cannot Say' items for this administration to be considered valid.|"
 .S TXT=TXT_CNT("cannotSay")_" were skipped; 18 is the maximum allowed."
 ;
 ;VRIN-r T-score greater than 79
 S SCRS=(TSARR("VRIN"))
 I $P(SCRS,U,3)>79 D
 .S TXT=TXT_"||INVALID RESULTS"
 .S TXT=TXT_"|The T score for the Variable Response Inconsistency Scale (VRIN-r) is equal to,|"
 .S TXT=TXT_"or greater than, 80."
 ;Is response percent below 70%
 I $P(SCRS,U,4)<70 S VSCALE=1
 ;
 ;TRIN-r T-score greater than 79
 S SCRS=TSARR("TRIN")
 I $P(SCRS,U,3)>79 D
 .S TXT=TXT_"||INVALID RESULTS"
 .S TXT=TXT_"|The T score for the True Response Inconsistency Scale (TRIN-r) is equal to,|"
 .S TXT=TXT_"or greater than, 80."
 ;  // Is response percent below 70%
 I $P(SCRS,U,4)<70 S VSCALE=1
 ;
 ;F-r T-score equals 120
 S SCRS=TSARR("F-r")
 I $P(SCRS,U,3)=120 D
 .S TXT=TXT_"||INVALID RESULTS"
 .S TXT=TXT_"|The T score for the Infrequent Responses Scale (F-r) is equal to 120."
 ; // Is response percent below 70%
 I $P(SCRS,U,4)<70 S VSCALE=1
 ;
 ;Fp-r T-score greater than 99
 S SCRS=TSARR("Fp-r")
 I $P(SCRS,U,3)>99 D
 .S TXT=TXT_"||INVALID RESULTS"
 .S TXT=TXT_"|The T score for the Infrequent Psychopathology Responses Scale (Fp-r) is equal to,|"
 .S TXT=TXT_"or greater than, 100."
 ;// Is response percent below 70%
 I $P(SCRS,U,4)<70 S VSCALE=1
 ;
 I VSCALE D
 .S TXT=TXT_"||INVALID RESULTS"
 .S TXT=TXT_"|One or more Validity Scale has a response percentage below 70%."
 ;
 D VLDTYSC^YTSMPI2V
 D HORCSC^YTSMPI2H
 D SOCOSC^YTSMPI2S
 D EIISC^YTSMPI2E
 D PSYSC^YTSMPI2Y
 D ITEM^YTSMPI2U
 D RESP^YTSMPI2U
 Q
