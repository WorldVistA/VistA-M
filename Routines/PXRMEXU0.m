PXRMEXU0 ; SLC/PKR - Reminder exchange general utilities, #0.;07/20/2009
 ;;2.0;CLINICAL REMINDERS;**4,12**;Feb 04, 2005;Build 73
 ;=========================================================
LOC(FDA) ;Process the FDA for location lists.
 ;Direct reads of ^DIC(40.7) covered by DBIA #537.
 N AMIS,IEN,IENS,SFN,STOP,TEMP,TEXT
 ;Stop Codes may not have a unique name, use the AMIS Reporting Stop
 ;code to determine which one to use.
 F SFN=810.9001,810.90011 D
 . S IENS=""
 . F  S IENS=$O(FDA(SFN,IENS)) Q:IENS=""  D
 .. S STOP=FDA(SFN,IENS,.01)
 .. S AMIS=FDA(SFN,IENS,.02)
 .. S IEN=$O(^DIC(40.7,"C",AMIS,""))
 .. S TEMP=$P(^DIC(40.7,IEN,0),U,1)
 .. I TEMP'=STOP D  Q
 ... S TEXT(1)="Name associated with AMIS stop code does not match the one in the"
 ... S TEXT(2)="packed reminder:"
 ... S TEXT(3)=" AMIS="_AMIS
 ... S TEXT(4)=" Site Name="_TEMP
 ... S TEXT(5)=" Name in packed reminder="_STOP
 ... D EN^DDIOL(.TEXT)
 .. S FDA(SFN,IENS,.01)="`"_IEN
 Q
 ;
 ;=========================================================
GETIEN(NFOUND,LIST) ;FIND^DIC has found multiple entries with the same name.
 ;NFOUND is the number found, LIST is the array returned by FIND^DIC.
 ;Ask the user which one they want to use.
 N DIR,FN,IND,NC,X,Y
 S DIR(0)="S^"
 F IND=1:1:NFOUND D
 . S DIR(0)=DIR(0)_IND_":"_LIST("DILIST",2,IND)_";"
 S DIR("L",1)="Select one of the following to use:"
 S NC=1
 F IND=1:1:NFOUND D
 . S NC=NC+1
 . S DIR("L",NC)=IND_"- "_LIST("DILIST",1,IND)_" IEN="_LIST("DILIST",2,IND)
 . S FN=$O(LIST("DILIST","ID",IND,""))
 . I FN="" Q
 . S NC=NC+1
 . S DIR("L",NC)="    "_LIST("DILIST","ID",IND,FN)
 . F  S FN=$O(LIST("DILIST","ID",IND,FN)) Q:FN=""  D
 .. I $L(LIST("DILIST","ID",IND,FN))=0 Q
 .. S NC=NC+1
 .. S DIR("L",NC)="    "_LIST("DILIST","ID",IND,FN)
 ;Truncate DIR("L") as required.
 S DIR("L")=DIR("L",NC) K DIR("L",NC)
 D ^DIR
 I Y="^" D
 . N TEXT
 . S TEXT(1)="Entering ""^"" tells Reminder Exchange the entry does not exist. You will be"
 . S TEXT(2)="ask for a replacement."
 . D EN^DDIOL(.TEXT)
 Q $S($D(Y(0)):Y(0),1:0)
 ;
 ;=========================================================
SFNFTC(IEN) ;Set the found/not found text line counts in the reminder
 ;definition.
 D SNMLA^PXRMFNFT(IEN)
 D SNMLF^PXRMFNFT(IEN,20)
 D SNMLF^PXRMFNFT(IEN,25)
 D SNMLL^PXRMFNFT(IEN)
 Q
 ;
