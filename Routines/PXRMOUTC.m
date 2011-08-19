PXRMOUTC ; SLC/PKR - Clinical Maintenance output. ;12/04/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,17**;Feb 04, 2005;Build 102
 ;================================================
CM(DEFARR,PXRMPDEM,PCLOGIC,RESLOGIC,RESDATE,FIEVAL,OUTTYPE) ;Prepare the 
 ;Clinical maintenance (OUTTYPE=5) and order check (OUTTPYPE=55)
 ;output.
 N IND,JND,FIDATA,FINDING,FLIST,FTYPE
 N HDR,NHDR,IFIEVAL,LIST,NFLINES,NTXT,NUM
 N TEMP,TEXT
 S NTXT=0
 ;Check for a dead patient
 I +$G(PXRMPDEM("DOD"))>0 D
 . S TEMP=$$FMTE^XLFDT(PXRMPDEM("DOD"),"5DZ")
 . S TEXT="Patient is deceased, date of death: "_TEMP
 . D ADDTXT^PXRMOUTU(1,PXRMRM,.NTXT,TEXT)
 ;Display the frequency information only if there is resolution logic.
 I RESLOGIC'="",OUTTYPE=5 D FREQ(.DEFARR,.NTXT,.TEXT)
 ;Output the AGE match/no match text.
 D AGE^PXRMFNFT(PXRMPDEM("DFN"),.DEFARR,.FIEVAL,.NTXT)
 ;Process the findings in the order: patient cohort, resolution,
 ;age, and informational.
 M FIDATA=FIEVAL
 F FTYPE="PCL","RES","AGE","INFO" D
 . S LIST=$S(FTYPE="PCL":DEFARR(32),FTYPE="RES":DEFARR(36),FTYPE="AGE":DEFARR(40),FTYPE="INFO":DEFARR(42))
 .;Output the general logic text.
 . I FTYPE="PCL" D LOGIC^PXRMFNFT(PXRMPDEM("DFN"),PCLOGIC,FTYPE,"D",.DEFARR,.NTXT)
 . I FTYPE="RES",$P(PCLOGIC,U,1) D LOGIC^PXRMFNFT(PXRMPDEM("DFN"),RESLOGIC,FTYPE,"D",.DEFARR,.NTXT)
 .;Process the findings for each type.
 . K TEXT
 . S (NHDR,NFLINES)=0
 . S NUM=+$P(LIST,U,1)
 . S FLIST=$P(LIST,U,2)
 . F IND=1:1:NUM D
 .. S FINDING=$P(FLIST,";",IND)
 ..;No output for age or sex findings.
 .. I (FINDING="AGE")!(FINDING="SEX") Q
 ..;Make sure each finding is processed only once.
 .. I '$D(FIDATA(FINDING)) Q
 .. K IFIEVAL
 .. I FIEVAL(FINDING) D
 ... M IFIEVAL=FIEVAL(FINDING)
 ...;Remove any false occurrences so they are not displayed.
 ... S JND=0
 ... F  S JND=+$O(IFIEVAL(JND)) Q:JND=0  K:'IFIEVAL(JND) IFIEVAL(JND)
 .. E  S IFIEVAL=0
 ..;If the finding is false all we need to do is process the not found
 ..;text. If it is true we also need to output the finding information.
 .. I IFIEVAL D FOUT(1,.IFIEVAL,.NFLINES,.TEXT)
 ..;Output the found/not found text for the finding.
FNF .. D FINDING^PXRMFNFT(3,PXRMPDEM("DFN"),FINDING,.IFIEVAL,.NFLINES,.TEXT)
 ..;Make sure each finding is processed only once.
 .. K FIDATA(FINDING)
 .;
 .;If there was any text for this finding type create a header.
 . I OUTTYPE=5 D HEADER(FTYPE,NFLINES,RESDATE,.NHDR,.HDR)
 .;Output the header and the finding text.
 . D ADDTXTA^PXRMOUTU(1,PXRMRM,.NTXT,NHDR,.HDR)
 . D COPYTXT^PXRMOUTU(.NTXT,NFLINES,.TEXT)
 ;Output INFO nodes
 D INFO^PXRMOUTU(PXRMITEM,.NTXT)
 Q
 ;
 ;================================================
FOUT(INDENT,IFIEVAL,NLINES,TEXT) ;Do output for individual findings 
 ;in the FINDING array.
 I $D(IFIEVAL("TERM")) D OUTPUT^PXRMTERM(1,.IFIEVAL,.NFLINES,.TEXT) Q
 N FTYPE
 S FTYPE=$P(IFIEVAL("FINDING"),U,1)
 S FTYPE=$P(FTYPE,";",2)
 I FTYPE="AUTTEDT(" D OUTPUT^PXRMEDU(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="AUTTEXAM(" D OUTPUT^PXRMEXAM(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="AUTTHF(" D OUTPUT^PXRMHF(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="AUTTIMM(" D OUTPUT^PXRMIMM(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="AUTTSK(" D OUTPUT^PXRMSKIN(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="GMRD(120.51," D OUTPUT^PXRMVITL(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="LAB(60," D OUTPUT^PXRMLAB(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="ORD(101.43," D OUTPUT^PXRMORDR(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PS(50.605," D OUTPUT^PXRMDRCL(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PSDRUG(" D OUTPUT^PXRMDRUG(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PSNDF(50.6," D OUTPUT^PXRMDGEN(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PS(55," D OUTPUT^PXRMDRUG(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PS(55NVA," D OUTPUT^PXRMDRUG(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PSRX(" D OUTPUT^PXRMDRUG(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PXD(811.2," D OUTPUT^PXRMTAX(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PXRMD(802.4," D OUTPUT^PXRMFF(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PXRMD(810.9," D OUTPUT^PXRMLOCF(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="PXRMD(811.4," D OUTPUT^PXRMCF(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="RAMIS(71," D OUTPUT^PXRMRAD(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 I FTYPE="YTT(601.71," D OUTPUT^PXRMMH(INDENT,.IFIEVAL,.NLINES,.TEXT) Q
 Q
 ;
 ;================================================
FREQ(DEFARR,NTXT,TEXT) ;Display the frequency information.
 N FREQ,TEMP
 ;If there was a custom date due print out that information.
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"zCDUE")) D
 . S TEMP=^TMP(PXRMPID,$J,PXRMITEM,"zCDUE")
 . S TEXT=$$OUTPUT^PXRMCDUE(TEMP,.DEFARR)
 . I DEFARR(31)["AGE" D
 .. S TEMP=$G(^TMP(PXRMPID,$J,PXRMITEM,"zFREQARNG"))
 .. I TEMP'="" S TEXT=TEXT_" Applicable"_$$FMTAGE^PXRMAGE($P(TEMP,U,2),$P(TEMP,U,3))_"."
 . D ADDTXT^PXRMOUTU(1,PXRMRM,.NTXT,TEXT)
 E  D
 . S TEMP=$G(^TMP(PXRMPID,$J,PXRMITEM,"zFREQARNG"))
 . I TEMP'="" D
 .. S FREQ=$P(TEMP,U,1)
 .. S TEXT=$$FMTFREQ^PXRMAGE(FREQ)
 .. I FREQ=-1 S TEXT=TEXT_" for this patient."
 .. I DEFARR(31)["AGE",FREQ'=-1 S TEXT=TEXT_$$FMTAGE^PXRMAGE($P(TEMP,U,2),$P(TEMP,U,3))_"."
 .. D ADDTXT^PXRMOUTU(1,PXRMRM,.NTXT,TEXT)
 Q
 ;
 ;================================================
HEADER(FTYPE,NLINES,RESDATE,NHDR,HDR) ;Create a finding header.
 K HDR
 I FTYPE="RES" D  Q
 . I +RESDATE'=0 D  Q
 .. S HDR(2)="Resolution: Last done "_$$EDATE^PXRMDATE(RESDATE)
 .. S NHDR=2
 .. S HDR(1)="\\"
 . I '$D(HDR(2)),NLINES>0 D
 .. S HDR(2)="Resolution:"
 .. S NHDR=2
 .. S HDR(1)="\\"
 ;
 I NLINES=0 Q
 I FTYPE="PCL" D  Q
 . S NHDR=2
 . S HDR(1)="\\"
 . S HDR(2)="Cohort:"
 ;
 I FTYPE="AGE" D  Q
 . S NHDR=2
 . S HDR(1)="\\"
 . S HDR(2)="Age/Frequency:"
 ;
 I FTYPE="INFO" D  Q
 . S NHDR=2
 . S HDR(1)="\\"
 . S HDR(2)="Information:"
 Q
 ;
