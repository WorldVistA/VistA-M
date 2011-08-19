SDFORM ;IOFO BAY PINES/ESW - FORMAT MESSAGES ;09/02/2004 2:10 PM [5/19/05 8:24am]
 ;;5.3;Scheduling;**327**;Aug 13, 1993
 ;This routine may be called to format a text up to four columns.
 ;The returned value may be asigned to an array element used in
 ;a message creation
 ;================================================
FORM(FIRST,FN,SECOND,SN,THIRD,TN,FOURTH,FRN) ;
 ;
 ;FIRST,SECOND,THIRD,FOURTH - names of variables containing text values or text strings 
 ;                                to be included in a formatted message
 ;FN,SN,TN - numbers assigned for a text and spaces up to the next column
 ;
 ;Output: formatted text
 ;
 N FS,SS,TS,FNS,SNS,TNS
 S:'$D(THIRD) THIRD=""
 S:'$D(FOURTH) FOURTH=""
 S:'$D(TN) TN=""
 S:'$D(SN) SN=""
 S:'$D(FRN) FRN=""
 S FNS=FN-$L(FIRST) S:FNS'>0 FNS=1,FIRST=$E(FIRST,1,$L(FIRST)-1) S $P(FS," ",FNS)=""
 S SNS=SN-$L(SECOND) S:SNS'>0 SNS=1,SECOND=$E(SECOND,1,$L(SECOND)-1) S $P(SS," ",SNS)=""
 S TNS=TN-$L(THIRD) S:TNS'>0 TNS=1,THIRD=$E(THIRD,1,$L(THIRD)-1) S $P(TS," ",TNS)=""
 Q FIRST_FS_SECOND_SS_THIRD_TS_FOURTH
