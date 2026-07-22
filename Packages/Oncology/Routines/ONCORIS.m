ONCORIS ;HINES OIFO/RTK,AJB - OncoTrax Data to ORIS ;07/28/25
 ;;2.2;ONCOLOGY;**23**;Jul 31, 2013;Build 6
 ; SAC EXEMPTION ID 202602221239-01 : For use of $ZF function
 ;
EN ;
 I $D(ZTQUEUED) D EN^ONCORIST  Q  ;if option is queued do ONCORIST
 ;
 W @IOF
 W !!!!,"========================================"
 W "======================================",!!
 W !!,"This option will migrate ONCOLOGY and other relevant data."
 W !!!!,"========================================"
 W "======================================",!!
 K DIR
 S DIR(0)="E",DIR("A")="Enter RETURN to begin data migration or '^' to quit"
 D ^DIR I 'Y Q
 S ONCAFDIV=$G(DUZ(2)),ONCDIVSP=$O(^ONCO(160.1,"C",ONCAFDIV,""))
 S ONCSVPTH=$P($G(^ONCO(160.1,ONCDIVSP,"SVPATH")),"^",1)
 S ONCACKEY=$P($G(^ONCO(160.1,ONCDIVSP,"ACCESSKEY")),"^",1)
 I (ONCSVPTH="")!(ONCACKEY="") D  Q
 .W !!!!,"*** Incorrect server set up or insufficient privileges ***"
 .W !!,"*** Unable to run migration option ***",!!!!
 .S DIR(0)="E",DIR("A")="Enter RETURN to exit" D ^DIR Q
 .Q
 D JSON
 Q
 ;
JSON ;
 ;
 ;first call GEN^ONCORISD to build the ONCO Migration (#160.9) file
 N ONCQ S ONCQ=""""
 N ONCT,ONCTZONE,ONCTHR,ONCTMN,ONCTSN D TIMENOW W !!,"Start: ",ONCDTNW
 D GEN^ONCORISD  ; builds the ONCO Migration file
 D GET200^ONCORISD  ; builds the ONCAR200 array for file #200 records used
 ;
 ;create json .txt file and put in /tmp using Kernel Device Handler
 W !!?4,"Migrating files...",!!
 N RECNUM,ONCTR S ONCTR=1
 N ONCQ S ONCQ=""""
 N ONCT,ONCTZONE,ONCTHR,ONCTMN,ONCTSN D TIMENOW
 N ONCFAC,ONCFACNM S ONCFAC=DUZ(2) S ONCFACNM=$P($$NS^XUAF4(ONCFAC),"^",1)
 ;
 D GETFILES
 ;
 ;Print out contents of the tarball for debugging purposes
 ;Send the tarball to ORIS on the AWS server
 W !,"Tarball created: ",!
 S X=$ZF(-100,"/SHELL","ls","-lh","/tmp/onc2oris.utility.tar")
 W !!,"Contents of onc2oris.utility.tar: ",!
 S X=$ZF(-100,"/SHELL","tar","-tvf","/tmp/onc2oris.utility.tar")
 N ONCT,ONCTZONE,ONCTHR,ONCTMN,ONCTSN D TIMENOW W !!,"Timestamp after Tarball created: ",ONCDTNW
 W !,"Sending tar file to ORIS...",!
 S X=$ZF(-100,"/SHELL","curl","-X","POST",ONCSVPTH,"-H",ONCACKEY,"-F","data=@/tmp/onc2oris.utility.tar")
 W !,"Done.",!
 ;
 ;Cleanup after ourselves
 S X=$ZF(-100,"/SHELL","rm","-f","/tmp/onc2oris.utility.tar", "/tmp/onc2oris.utility/metadata.txt")
 S X=$ZF(-100,"/SHELL","rm","-rf","/tmp/onc2oris.utility")
 ;
 D TIMENOW W !!,"Finish: ",ONCDTNW,!!!!
 K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue"
 D ^DIR I 'Y Q
 Q
 ;
GETFILES ;get all the files/data in json format
 ; cleanup work from any previous runs
 S X=$ZF(-100,"/SHELL","rm","-rf","/tmp/onc2oris.utility")
 S X=$ZF(-100,"/SHELL","rm","-f","/tmp/onc2oris.utility.txt", "/tmp/onc2oris.utility.tar")
 S X=$ZF(-100,"/SHELL","mkdir", "/tmp/onc2oris.utility")
 ;First build header
 S IOP="ORIS-HFS",%ZIS="Q" D ^%ZIS
 U IO
 W !,"{"
 W !,"  ","""_MetaData"""_" :"
 W !,"  {"
 W !,"    "_"""Facility"""_" : "_ONCQ_ONCFACNM_ONCQ_","
 W !,"    "_"""GeneratedAt"""_" : "_ONCDTNW
 W !,"  },"
 W !,"}"
 D ^%ZISC
 S X=$ZF(-100,"/SHELL", "mv", "/tmp/onc2oris.utility.txt", "/tmp/onc2oris.utility/metadata.txt")
 ;
 ;Create a new tarball and load in the metadata file.
 S X=$ZF(-100,"/SHELL","tar","-cf","/tmp/onc2oris.utility.tar", "-C", "/tmp/onc2oris.utility/", "metadata.txt")
 ;
 ;Use Oncoris Mapping (#160.9) File to get files and fields to migrate
 ;
 S ONCMAPN=0 F  S ONCMAPN=$O(^ONCO(160.9,ONCMAPN)) Q:ONCMAPN'>0  D
 .S FILENUM=$P($G(^ONCO(160.9,ONCMAPN,0)),"^",1)
 .S IOP="ORIS-HFS",%ZIS="Q" D ^%ZIS
 .U IO
 .I FILENUM=160.9 Q  ;no need to migrate my map file
 .W !,"{" ;opening curly bracket
 .W !,"  ",ONCQ_FILENUM_ONCQ_" :"
 .W !,"  {"
 .I ((FILENUM>159.99)&(FILENUM<170)) D
 ..S RECNUM=0 F  S RECNUM=$O(^ONCO(FILENUM,RECNUM)) Q:RECNUM'>0  D GETREC
 .I ((FILENUM<160)!(FILENUM>169.99)) D
 ..D NONONC
 .W !,"  }" I FILENUM<99999 W ","
 .W !,"}"  ; add final closed curly bracket
 .D ^%ZISC
 .S X=$ZF(-100,"/SHELL", "mv", "/tmp/onc2oris.utility.txt", "/tmp/onc2oris.utility/"_FILENUM_".txt")
 .S X=$ZF(-100,"/SHELL","wc","-c","/tmp/onc2oris.utility/"_FILENUM_".txt")
 .;Compress the current file into a .gz file and then delete the original txt file
 .S X=$ZF(-100,"/SHELL","gzip","-f","/tmp/onc2oris.utility/"_FILENUM_".txt")
 .S X=$ZF(-100,"/SHELL","rm","-f","/tmp/onc2oris.utility/"_FILENUM_".txt")
 .;Load the compressed file into the tarball and then delete it
 .S X=$ZF(-100,"/SHELL","tar","-rf","/tmp/onc2oris.utility.tar", "-C", "/tmp/onc2oris.utility/",FILENUM_".txt.gz")
 .S X=$ZF(-100,"/SHELL","rm","-f","/tmp/onc2oris.utility/"_FILENUM_".txt.gz")
 .Q
 ;
 ;
 W !,"All files exported from VistA successfully.",!!
 K DDNUM,FILENUM,RECNUM,RECDATA,NODE,ONCDTNW,OLDLINE,NEWLINE
 Q
 ;
GETREC ;
 I $P($G(^ONCO(FILENUM,RECNUM,0)),"^",1)="" Q  ; skip bad/broken records
 W !,"    "_ONCQ_RECNUM_ONCQ_" :"
 W !,"    {"
 N DDNUM,DATYPE
 S ONCREFLG=""
 S ONCFDMUL=0 F  S ONCFDMUL=$O(^ONCO(160.9,ONCMAPN,1,ONCFDMUL)) Q:ONCFDMUL'>0  D
 .S DDNUM=$P($G(^ONCO(160.9,ONCMAPN,1,ONCFDMUL,0)),"^",1)
 .S DATYPE=$P($G(^ONCO(160.9,ONCMAPN,1,ONCFDMUL,0)),"^",2)
 .N FDNAME,NODE,NODEPC,PIECE,RECDATA
 .S FDNAME=$P($G(^DD(FILENUM,DDNUM,0)),"^",1)  ;field name
 .S NODEPC=$P($G(^DD(FILENUM,DDNUM,0)),"^",4)  ;position
 .S NODE=$P(NODEPC,";",1),PIECE=$P(NODEPC,";",2)
 .I DATYPE="MULTIPLE" D MULT Q
 .I DATYPE="WORD-PROCESSING" D  Q
 ..I FILENUM=160 D WPF160 Q
 ..I FILENUM=165.5 D WPF1655 Q
 ..Q
 .S RECDATA=$P($G(^ONCO(FILENUM,RECNUM,NODE)),"^",PIECE)
 .I RECDATA="" Q
 .I ONCREFLG'="" W ","
 .S ONCREFLG=1
 .I DATYPE="FREE TEXT" S OLDLINE=RECDATA D ESCAPE S RECDATA=NEWLINE
 .I DATYPE'="NUMERIC" W !,"      "_ONCQ_DDNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 .I DATYPE="NUMERIC" D
 ..S RECDATA=+RECDATA
 ..I RECDATA?1".".N S RECDATA="0"_RECDATA
 ..W !,"      "_ONCQ_DDNUM_ONCQ_" : "_RECDATA
 .Q
 W !,"    }" I $O(^ONCO(FILENUM,RECNUM))>0 W ","
 Q
 ;
NONONC ;files outside of ONC namespace
 ;
 I FILENUM=2 D  ; only get patient file records that are in ONC
 .S ONCDPT="",RECNUM=""
 .F  S ONCDPT=$O(^ONCO(160,"B",ONCDPT)) Q:ONCDPT=""  D
 ..I ONCDPT["LRT" Q
 ..S RECNUM=$P(ONCDPT,";",1) Q:RECNUM=""  Q:'$D(^DPT(RECNUM))  D GTD
 I FILENUM=4 S RECNUM=0 F  S RECNUM=$O(^DIC(4,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=4.11 S RECNUM=0 F  S RECNUM=$O(^DIC(4.11,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=5 S RECNUM=0 F  S RECNUM=$O(^DIC(5,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=5.11 S RECNUM=0 F  S RECNUM=$O(^VIC(5.11,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=10 S RECNUM=0 F  S RECNUM=$O(^DIC(10,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=11 S RECNUM=0 F  S RECNUM=$O(^DIC(11,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=11.99 S RECNUM=0 F  S RECNUM=$O(^DGMMS(11.99,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=20 S RECNUM=0 F  S RECNUM=$O(^VA(20,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=20.11 S RECNUM=0 F  S RECNUM=$O(^DIC(20.11,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=21 S RECNUM=0 F  S RECNUM=$O(^DIC(21,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=40.8 S RECNUM=0 F  S RECNUM=$O(^DG(40.8,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=45.7 S RECNUM=0 F  S RECNUM=$O(^DIC(45.7,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=50 S RECNUM=0 F  S RECNUM=$O(^PSDRUG(RECNUM)) Q:RECNUM'>0  D GTD
 ;I FILENUM=67 S RECNUM=0 F  S RECNUM=$O(^LRT(67,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=67 D  ; only get referral file records that are in ONC
 .S ONCLRT="",RECNUM=""
 .F  S ONCLRT=$O(^ONCO(160,"B",ONCLRT)) Q:ONCLRT=""  D
 ..I ONCLRT["DPT" Q
 ..S RECNUM=$P(ONCLRT,";",1) Q:RECNUM=""  Q:'$D(^LRT(67,RECNUM))  D GTD
 I FILENUM=75.1 S RECNUM=0 F  S RECNUM=$O(^RAO(75.1,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=80 S RECNUM=0 F  S RECNUM=$O(^ICD9(RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=200 S RECNUM=0 F  S RECNUM=$O(^VA(200,RECNUM)) Q:RECNUM'>0  D
 .I '$D(ONCAR200(RECNUM)) Q
 .D GTD
 I FILENUM=771.7 S RECNUM=0 F  S RECNUM=$O(^HL(771.7,RECNUM)) Q:RECNUM'>0  D GTD
 I FILENUM=9000010 S RECNUM=0 F  S RECNUM=$O(^AUPNVSIT(RECNUM)) Q:RECNUM'>0  D GTD
 Q
 ;
GTD ; get the data
 I (FILENUM=2)&($P($G(^DPT(RECNUM,0)),"^",1)="") Q  ;if .01 of any rec="" Q
 I (FILENUM=67)&($P($G(^LRT(67,RECNUM,0)),"^",1)="") Q
 I (FILENUM=200)&($P($G(^VA(200,RECNUM,0)),"^",1)="") Q
 W !,"    "_ONCQ_RECNUM_ONCQ_" :"
 W !,"    {"
 N DDNUM,DATYPE
 S ONCREFLG=""
 S ONCFDMUL=0 F  S ONCFDMUL=$O(^ONCO(160.9,ONCMAPN,1,ONCFDMUL)) Q:ONCFDMUL'>0  D
 .S DDNUM=$P($G(^ONCO(160.9,ONCMAPN,1,ONCFDMUL,0)),"^",1)
 .S DATYPE=$P($G(^ONCO(160.9,ONCMAPN,1,ONCFDMUL,0)),"^",2)
 .N FDNAME,NODE,NODEPC,PIECE,RECDATA
 .S FDNAME=$P($G(^DD(FILENUM,DDNUM,0)),"^",1)  ;field name
 .S NODEPC=$P($G(^DD(FILENUM,DDNUM,0)),"^",4)  ;position
 .S NODE=$P(NODEPC,";",1),PIECE=$P(NODEPC,";",2)
 .I DATYPE="MULTIPLE" D  ;for now only file #2, #200 for NON-ONC multiples
 ..I FILENUM=2 D MULT2^ONCORIS1
 ..I FILENUM=200 D MULT200^ONCORIS1
 ..I FILENUM=5 D MULT5^ONCORIS1
 ..I FILENUM=50 D MULT50^ONCORIS1
 .I DATYPE="WORD-PROCESSING" Q  ;for now no NON-ONC word-processing fields
 .I FILENUM=2 S RECDATA=$P($G(^DPT(RECNUM,NODE)),"^",PIECE)
 .I FILENUM=4 S RECDATA=$P($G(^DIC(4,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=4.11 S RECDATA=$P($G(^DIC(4.11,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=5 S RECDATA=$P($G(^DIC(5,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=5.11 S RECDATA=$P($G(^VIC(5.11,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=10 S RECDATA=$P($G(^DIC(10,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=11 S RECDATA=$P($G(^DIC(11,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=11.99 S RECDATA=$P($G(^DGMMS(11.99,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=20 S RECDATA=$P($G(^VA(20,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=20.11 S RECDATA=$P($G(^DIC(20.11,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=21 S RECDATA=$P($G(^DIC(21,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=40.8 S RECDATA=$P($G(^DG(40.8,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=45.7 S RECDATA=$P($G(^DIC(45.7,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=50 S RECDATA=$P($G(^PSDRUG(RECNUM,NODE)),"^",PIECE)
 .I FILENUM=67 S RECDATA=$P($G(^LRT(67,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=75.1 S RECDATA=$P($G(^RAO(75.1,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=80 S RECDATA=$P($G(^ICD9(RECNUM,NODE)),"^",PIECE)
 .I FILENUM=200 S RECDATA=$P($G(^VA(200,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=771.7 S RECDATA=$P($G(^HL(771.7,RECNUM,NODE)),"^",PIECE)
 .I FILENUM=9000010 S RECDATA=$P($G(^AUPNVSIT(RECNUM,NODE)),"^",PIECE)
 .I RECDATA="" Q
 .I ONCREFLG'="" W ","
 .S ONCREFLG=1
 .I DATYPE="FREE TEXT" S OLDLINE=RECDATA D ESCAPE S RECDATA=NEWLINE
 .I DATYPE'="NUMERIC" W !,"      "_ONCQ_DDNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 .I DATYPE="NUMERIC" D
 ..S RECDATA=+RECDATA
 ..I RECDATA?1".".N S RECDATA="0"_RECDATA
 ..W !,"      "_ONCQ_DDNUM_ONCQ_" : "_RECDATA
 .Q
 W !,"    }" D COMMCHK  ;if not last record print a comma
 Q
 ;
COMMCHK ;check if last record, if it's not write a comma if it is do not
 I FILENUM=2 I $O(^DPT(RECNUM))>0 W ","
 I FILENUM=4 I $O(^DIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=4.11 I $O(^DIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=5 I $O(^DIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=5.11 I $O(^VIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=10 I $O(^DIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=11 I $O(^DIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=11.99 I $O(^DGMMS(FILENUM,RECNUM))>0 W ","
 I FILENUM=20 I $O(^VA(FILENUM,RECNUM))>0 W ","
 I FILENUM=20.11 I $O(^DIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=21 I $O(^DIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=40.8 I $O(^DG(FILENUM,RECNUM))>0 W ","
 I FILENUM=45.7 I $O(^DIC(FILENUM,RECNUM))>0 W ","
 I FILENUM=50 I $O(^PSDRUG(RECNUM))>0 W ","
 I FILENUM=67 I $O(^LRT(FILENUM,RECNUM))>0 W ","
 I FILENUM=75.1 I $O(^RAO(FILENUM,RECNUM))>0 W ","
 I FILENUM=80 I $O(^ICD9(RECNUM))>0 W ","
 I FILENUM=200 I $O(^VA(FILENUM,RECNUM))>0 W ","
 I FILENUM=771.7 I $O(^HL(FILENUM,RECNUM))>0 W ","
 I FILENUM=9000010 I $O(^AUPNVSIT(RECNUM))>0 W ","
 Q
 ;
FLDTYP ;determine if field is a word processing or multiple field
 ; if a word processing field return "W", if multiple field return "M"
 S ONCFDTY="M"
 S DDSUB=+$P($G(^DD(FILENUM,DDNUM,0)),"^",2)
 I $P($G(^DD(DDSUB,.01,0)),"^",2)["W" S ONCFDTY="W"
 Q
 ;
MULT ;
 S ONCMUFLG=""
 S DDSUB=+$P($G(^DD(FILENUM,DDNUM,0)),"^",2)
 S SUBNODEN=$P($G(^DD(FILENUM,DDNUM,0)),"^",4)
 S SUBNODE=$P(SUBNODEN,";",1)
 I $O(^ONCO(FILENUM,RECNUM,SUBNODE,0))="" Q
 W ","  ;write the comma for previous field; assume first field not MULT/WP
 W !,"      "_ONCQ_DDNUM_ONCQ_" :"
 W !,"      {"
 S SBRECNUM=0 F  S SBRECNUM=$O(^ONCO(FILENUM,RECNUM,SUBNODE,SBRECNUM)) Q:SBRECNUM'>0  D
 .I $P($G(^ONCO(FILENUM,RECNUM,SUBNODE,SBRECNUM,0)),"^",1)="" Q
 .S ONCMUFLG=""
 .W !,"        "_ONCQ_SBRECNUM_ONCQ_" :"
 .W !,"        {"
 .S DDSUBNUM=0 F  S DDSUBNUM=$O(^DD(DDSUB,DDSUBNUM)) Q:DDSUBNUM'>0  D
 ..N DATYPE,FDNAME,NODE,NODEPC,PIECE,RECDATA
 ..S FDNAME=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",1)  ;sub-field name
 ..S DATYPE=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",2)  ;sub-field data type
 ..S NODEPC=$P($G(^DD(DDSUB,DDSUBNUM,0)),"^",4)  ;sub-field position
 ..I NODEPC=" ; " Q
 ..S NODE=$P(NODEPC,";",1),PIECE=$P(NODEPC,";",2)
 ..I $P(NODEPC,";",2)=0 D  Q
 ...I FILENUM=160 D WPF160
 ..S RECDATA=$P($G(^ONCO(FILENUM,RECNUM,SUBNODE,SBRECNUM,NODE)),"^",PIECE)
 ..I RECDATA="" Q
 ..I ONCMUFLG'="" W ","
 ..S ONCMUFLG=1
 ..I DATYPE["F" S OLDLINE=RECDATA D ESCAPE S RECDATA=NEWLINE
 ..I DATYPE'["N" W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 ..I DATYPE["N" D
 ...S RECDATA=+RECDATA
 ...I RECDATA?1".".N S RECDATA="0"_RECDATA
 ...W !,"          "_ONCQ_DDSUBNUM_ONCQ_" : "_RECDATA
 ..Q
 .W !,"        }" I $O(^ONCO(FILENUM,RECNUM,SUBNODE,SBRECNUM))>0 W ","
 W !,"      }"
 Q
 ;
WPF1655 ;Word processing fields in file #165.5
 S RECDATA=$$WORD^ONCACDU2(RECNUM,NODE,4000)
 I RECDATA="" Q
 S OLDLINE=RECDATA D ESCAPE S RECDATA=NEWLINE
 W ","  ;write comma for previous fields; assume first field not WP
 W !,"      ",ONCQ_DDNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 Q
 ;
WPF160 ;
 I DDNUM'=400 S RECDATA=$$WORD(RECNUM,4,4000)
 I DDNUM=400 S RECDATA=$$WPFSUB(RECNUM,SBRECNUM,4000)
 I RECDATA="" Q
 S OLDLINE=RECDATA D ESCAPE S RECDATA=NEWLINE
 I DDNUM'=400 W ","  ;write comma for previous field; assume first not WP
 I DDNUM'=400 W !,"      ",ONCQ_DDNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 I DDNUM=400 W ","  ;write comma for prev fld; assume first field not WP
 I DDNUM=400 W !,"          ",ONCQ_DDSUBNUM_ONCQ_" : "_ONCQ_RECDATA_ONCQ
 Q
 ;
WORD(IEN,NODE,LEN)  ;Get word processing data
 N X S X=""
 I $D(^ONCO(160,IEN,NODE,1)) D
 .N CNT,LINE,ONCLINE
 .S CNT=0
 .S (LINE,ONCLINE)=""
 .F  S CNT=$O(^ONCO(160,IEN,NODE,CNT)) Q:CNT'>0  D  Q:($L(ONCLINE)>LEN)
 ..Q:'$D(^ONCO(160,IEN,NODE,CNT,0))
 ..S ONCLINE=LINE_^ONCO(160,IEN,NODE,CNT,0)_" "
 ..I ($L(ONCLINE)>LEN) S LINE=$E(ONCLINE,1,LEN) Q
 ..S LINE=LINE_^ONCO(160,IEN,NODE,CNT,0)_" "
 .S X=LINE
 S X=$TR(X,$C(10,12,13),"   ")
 Q X
 ;
WPFSUB(IEN,SUBIEN,LEN) ;Get word processing data for sub-field #400
 ; in file #160
 N X S X=""
 I $D(^ONCO(160,IEN,"F",SUBIEN,1)) D
 .N CNT,LINE,ONCLINE
 .S CNT=0
 .S (LINE,ONCLINE)=""
 .F  S CNT=$O(^ONCO(160,IEN,"F",SUBIEN,1,CNT)) Q:CNT<1  D  Q:($L(ONCLINE)>LEN)
 ..Q:'$D(^ONCO(160,IEN,"F",SUBIEN,1,CNT,0))
 ..S ONCLINE=LINE_^ONCO(160,IEN,"F",SUBIEN,1,CNT,0)_" "
 ..I ($L(ONCLINE)>LEN) S LINE=$E(ONCLINE,1,LEN) Q
 ..S LINE=LINE_^ONCO(160,IEN,"F",SUBIEN,1,CNT,0)_" "
 .S X=LINE
 S X=$TR(X,$C(10,12,13),"   ")
 Q X
 ;
ESCAPE ; escape " and \ characters and strip out non-printable ASCII chars
 I OLDLINE="" Q
 S NEWLINE=""
 F N=1:1:$L(OLDLINE) D
 .S CHAR=$E(OLDLINE,N)
 .I CHAR="""" S NEWLINE=NEWLINE_"\""" Q
 .I CHAR="\" S NEWLINE=NEWLINE_"\\" Q
 .I ($ASCII(CHAR)<32)!($ASCII(CHAR)>126) Q
 .S NEWLINE=NEWLINE_CHAR
 Q
 ;
TIMENOW ;
 S ONCT=$$NOW^XLFDT(),ONCTZONE=$$TZ^XLFDT()
 S ONCTHR=$E(ONCT,9,10),ONCTMN=$E(ONCT,11,12),ONCTSN=$E(ONCT,13,14)
 S:ONCTSN="" ONCTSN="00"
 S:($L(ONCTSN)=1) ONCTSN="0"_ONCTSN
 S ONCTSN=ONCTSN_".000"_$E(ONCTZONE,1,3)_":"_$E(ONCTZONE,4,5)
 ;S ONCDTNW=""""_(1700+$E(ONCT,1,3))_"-"_$E(ONCT,4,5)_"-"_$E(ONCT,6,7)_"T"_ONCTHR_":"_ONCTMN_":"_ONCTSN_""""
 S ONCDTNW=ONCQ_(1700+$E(ONCT,1,3))_"-"_$E(ONCT,4,5)_"-"_$E(ONCT,6,7)_"T"_ONCTHR_":"_ONCTMN_":"_ONCTSN_ONCQ
 Q
 ;
END ;
 Q
