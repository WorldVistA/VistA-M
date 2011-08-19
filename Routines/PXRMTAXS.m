PXRMTAXS ; SLC/PKR - Taxonomy search routines. ;12/14/2009
 ;;2.0;CLINICAL REMINDERS;**4,17**;Feb 04, 2005;Build 102
 ;
 ;=====================================================
CSEARCH(FILENUM,CODE,CODEIEN,CODETYPE,NFOUND,TAXLIST) ; Search
 ;all taxonomies to see if they contain CODE.
 N PTR,TAX,TAXIEN
 S PTR=$S(FILENUM=80:"ICD9P",FILENUM=80.1:"ICD0P",FILENUM=81:"ICPTP",1:"")
 I PTR="" Q
 K TAXLIST
 S NFOUND=0,TAX=""
 F  S TAX=$O(^PXD(811.2,"B",TAX)) Q:TAX=""  D
 . S TAXIEN=$O(^PXD(811.2,"B",TAX,""))
 .;Make sure the expansion exists.
 . I '$D(^PXD(811.3,TAXIEN)) D EXPAND^PXRMBXTL(TAXIEN,"")
 . I $D(^PXD(811.3,TAXIEN,FILENUM,PTR,CODEIEN)) S NFOUND=NFOUND+1,TAXLIST(TAX)=""
 Q
 ;
 ;=====================================================
SEARCH ; Let the user input a code then search all taxonomies to see
 ;if it is being used.
 N CODE,CODEIEN,CODETYPE,DIR,DIRUT,DTOUT,DUOUT,NFOUND
 N TAX,TAXLIST,RETVAL,VALID,Y
 S DIR(0)="FAOU"
 S DIR("A")="Input a code to search for: "
GCODE W !
 D ^DIR
 I $D(DIRUT) Q
 S CODE=Y
 ;See if this is a valid code.
 S VALID=0
 S RETVAL=$$CODE^PXRMVAL(CODE,80)
 I $P(RETVAL,U,1)=1 S VALID=80
 I VALID=0 D
 . S RETVAL=$$CODE^PXRMVAL(CODE,80.1)
 . I $P(RETVAL,U,1)=1 S VALID=80.1
 I VALID=0 D
 . S RETVAL=$$CODE^PXRMVAL(CODE,81)
 . I $P(RETVAL,U,1)=1 S VALID=81
 I VALID=0 W !,CODE," is not a valid code, try again." G GCODE
 S CODETYPE=$P(RETVAL,U,7)
 S CODEIEN=$P(RETVAL,U,8)
 D CSEARCH(VALID,CODE,CODEIEN,CODETYPE,.NFOUND,.TAXLIST)
 I NFOUND=0 W !,CODE," is not used in any taxonmies." Q
 W !,CODETYPE," ",CODE," is used in the following taxonomies:"
 S TAX=""
 F  S TAX=$O(TAXLIST(TAX)) Q:TAX=""  W !," ",TAX
 G GCODE
 Q
 ; 
 ;=====================================================
SETVAR(TAXARR,ENS,INS,NICD0,NICD9,NCPT,NRCPT,PLS,RAS) ;
 N ALL,TEMP
 ;Initialize the taxonomy search variables.
 S TEMP=$G(TAXARR(0))
 S NICD0=+$P(TEMP,U,3)
 S NICD9=+$P(TEMP,U,5)
 S NCPT=+$P(TEMP,U,7)
 S NRCPT=+$P(TEMP,U,9)
 ;Setup the Patient Data Source control variables.
 S TEMP=$P(TAXARR(811.2,0),U,4)
 ;The default is to search all locations.
 S ALL=$S(TEMP="":1,TEMP="ALL":1,1:0)
 I ALL S (ENS,INS,PLS,RAS)=1 Q
 S ENS=$S(TEMP["EN":1,1:0)
 S INS=$S(TEMP["IN":1,1:0)
 S PLS=$S(TEMP["PL":1,1:0)
 S RAS=$S(TEMP["RA":1,1:0)
 Q
 ;
