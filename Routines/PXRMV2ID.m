PXRMV2ID ; SLC/PKR - Version 2.0 init routine (dates). ;07/01/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 Q
 ;
 ;===============================================================
CEDATE ;Find all reminder and term findings that have an ending date.
 ;Ask the user if it should be moved to a beginning date.
 N BDATE,DIR,DIROUT,DTOUT,DUOUT,EDATE,IEN,IND,FINDING,FNAME
 N RNAME,TEMP,TEXT,X,Y
 W !,"Checking reminder definitions for ending dates."
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S RNAME=$P(^PXD(811.9,IEN,0),U,1)
 . S IND=0
 . F  S IND=+$O(^PXD(811.9,IEN,20,IND)) Q:IND=0  D
 .. S TEMP=^PXD(811.9,IEN,20,IND,0)
 .. S EDATE=$P(TEMP,U,11)
 .. I EDATE'="" D
 ... S BDATE=$P(TEMP,U,8)
 ... S FINDING=$P(TEMP,U,1)
 ... S TEMP="^"_$P(FINDING,";",2)_$P(FINDING,";",1)_",0)"
 ... S FNAME=$P(@TEMP,U,1)
 ... W !!,"Reminder ",RNAME
 ... W !," Finding ",FNAME," has an ending date."
 ... W !," The ending date is ",EDATE
 ... S TEXT=$S(BDATE="":"NULL",1:BDATE)
 ... W !," The beginning date is ",TEXT
 ... W !," Move the ending date to the beginning date and delete the ending date?"
 ... S DIR(0)="Y"_U_"AO",DIR("B")="NO"
 ... D ^DIR
 ... I Y D
 .... S $P(^PXD(811.9,IEN,20,IND,0),U,8)=$$COTN^PXRMDATE(EDATE)
 .... S $P(^PXD(811.9,IEN,20,IND,0),U,11)=""
 ;
 W !!,"Checking reminder terms for ending dates."
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.5,IEN)) Q:IEN=0  D
 . S RNAME=$P(^PXRMD(811.5,IEN,0),U,1)
 . S IND=0
 . F  S IND=+$O(^PXRMD(811.5,IEN,20,IND)) Q:IND=0  D
 .. S TEMP=^PXRMD(811.5,IEN,20,IND,0)
 .. S EDATE=$P(TEMP,U,11)
 .. I EDATE'="" D
 ... S BDATE=$P(TEMP,U,8)
 ... S FINDING=$P(TEMP,U,1)
 ... S TEMP="^"_$P(FINDING,";",2)_$P(FINDING,";",1)_",0)"
 ... S FNAME=$P(@TEMP,U,1)
 ... W !!,"Reminder ",RNAME
 ... W !," Finding ",FNAME," has an ending date."
 ... W !," The ending date is ",EDATE
 ... S TEXT=$S(BDATE="":"NULL",1:BDATE)
 ... W !," The beginning date is ",TEXT
 ... W !," Move the ending date to the beginning date and delete the ending date?"
 ... S DIR(0)="Y"_U_"AO",DIR("B")="NO"
 ... D ^DIR
 ... I Y D
 .... S $P(^PXRMD(811.5,IEN,20,IND,0),U,8)=$$COTN^PXRMDATE(EDATE)
 .... S $P(^PXRMD(811.5,IEN,20,IND,0),U,11)=""
 W !," DONE"
 Q
 ;
 ;===============================================================
CEFFDATE ;Convert effective dates to beginning dates.
 N EDATE,IEN,IND,FINDING,FNAME,RNAME,TEMP,TEXT
 ;Only do this once.
 I $$VERSION^XPDUTL("PXRM")["2.0" Q
 D BMES^XPDUTL("Converting Effective Dates to Beginning Dates")
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S RNAME=$P(^PXD(811.9,IEN,0),U,1)
 . S TEXT=" Working on reminder "_IEN
 . D BMES^XPDUTL(TEXT)
 . S IND=0
 . F  S IND=+$O(^PXD(811.9,IEN,20,IND)) Q:IND=0  D
 .. S TEMP=^PXD(811.9,IEN,20,IND,0)
 .. S EDATE=$P(TEMP,U,11)
 .. I EDATE'="" D
 ... S FINDING=$P(TEMP,U,1)
 ... S TEMP="^"_$P(FINDING,";",2)_$P(FINDING,";",1)_",0)"
 ... S FNAME=$P(@TEMP,U,1)
 ... S TEXT="Moving Effective Date to Beginning Date for reminder "_RNAME
 ... D BMES^XPDUTL(TEXT)
 ... S TEXT="  finding "_FNAME
 ... D BMES^XPDUTL(TEXT)
 ... S $P(^PXD(811.9,IEN,20,IND,0),U,8)=$$COTN^PXRMDATE(EDATE)
 ... S $P(^PXD(811.9,IEN,20,IND,0),U,11)=""
 ;
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.5,IEN)) Q:IEN=0  D
 . S TEXT=" Working on term "_IEN
 . D BMES^XPDUTL(TEXT)
 . S RNAME=$P(^PXRMD(811.5,IEN,0),U,1)
 . S IND=0
 . F  S IND=+$O(^PXRMD(811.5,IEN,20,IND)) Q:IND=0  D
 .. S TEMP=^PXRMD(811.5,IEN,20,IND,0)
 .. S EDATE=$P(TEMP,U,11)
 .. I EDATE'="" D
 ... S FINDING=$P(TEMP,U,1)
 ... S TEMP="^"_$P(FINDING,";",2)_$P(FINDING,";",1)_",0)"
 ... S FNAME=$P(@TEMP,U,1)
 ... S TEXT="Moving Effective Date to Beginning Date for term "_RNAME
 ... D BMES^XPDUTL(TEXT)
 ... S TEXT="  finding "_FNAME
 ... D BMES^XPDUTL(TEXT)
 ... S $P(^PXRMD(811.5,IEN,20,IND,0),U,8)=$$COTN^PXRMDATE(EDATE)
 ... S $P(^PXRMD(811.5,IEN,20,IND,0),U,11)=""
 D BMES^XPDUTL(" DONE")
 Q
 ;
 ;===============================================================
CFDATE ;Convert the beginning and ending dates in the finding multiple
 ;to the new format.
 N IEN,IND,NEWDATE,OLDDATE,TEMP,TEXT
 D BMES^XPDUTL("Setting finding dates to new format.")
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S TEXT=" Working on reminder "_IEN
 . D BMES^XPDUTL(TEXT)
 . S IND=0
 . F  S IND=+$O(^PXD(811.9,IEN,20,IND)) Q:IND=0  D
 .. S TEMP=^PXD(811.9,IEN,20,IND,0)
 .. S OLDDATE=$P(TEMP,U,8)
 .. I OLDDATE'="" D
 ... S NEWDATE=$$COTN^PXRMDATE(OLDDATE)
 ... S $P(^PXD(811.9,IEN,20,IND,0),U,8)=NEWDATE
 .. S OLDDATE=$P(TEMP,U,11)
 .. I OLDDATE'="" D
 ... S NEWDATE=$$COTN^PXRMDATE(OLDDATE)
 ... S $P(^PXD(811.9,IEN,20,IND,0),U,11)=NEWDATE
 ;
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.5,IEN)) Q:IEN=0  D
 . S TEXT=" Working on term "_IEN
 . D BMES^XPDUTL(TEXT)
 . S IND=0
 . F  S IND=+$O(^PXRMD(811.5,IEN,20,IND)) Q:IND=0  D
 .. S TEMP=^PXRMD(811.5,IEN,20,IND,0)
 .. S OLDDATE=$P(TEMP,U,8)
 .. I OLDDATE'="" D
 ... S NEWDATE=$$COTN^PXRMDATE(OLDDATE)
 ... S $P(^PXRMD(811.5,IEN,20,IND,0),U,8)=NEWDATE
 .. S OLDDATE=$P(TEMP,U,11)
 .. I OLDDATE'="" D
 ... S NEWDATE=$$COTN^PXRMDATE(OLDDATE)
 ... S $P(^PXRMD(811.5,IEN,20,IND,0),U,11)=NEWDATE
 D BMES^XPDUTL(" DONE")
 Q
 ;
