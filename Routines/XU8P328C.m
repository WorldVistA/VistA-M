XU8P328C ;OIFOO/SO- POST INSTALL;7:22 AM  8 Mar 2004
 ;;8.0;KERNEL;**328**;Jul 10, 1995
 ;
DES D MES^XPDUTL("Updating STATE(#5) file's Description.") ;IA# 4293
 K ^DIC(5,"%D")
 S ^DIC(5,"%D",0)="^^5^5^3031105^"
 S ^DIC(5,"%D",1,0)="This file contains the name of the state (or outlying area) as issued"
 S ^DIC(5,"%D",2,0)="by the Department of Veterans Affairs and issued in M-1, Part I,"
 S ^DIC(5,"%D",3,0)="Appendix B.  These entries should remain as distributed and should not be"
 S ^DIC(5,"%D",4,0)="edited or updated unless done via a software upgrade or under direction"
 S ^DIC(5,"%D",5,0)="of VA Central Office."
 ;
RIX ;REINDEX THE 'C' XREF OF THE COUNTY MULTIPLE
 D MES^XPDUTL("Reindexing the ""C"" cross reference of the COUNTY multiple...")
 N IEN S IEN=0
 F  S IEN=$O(^DIC(5,IEN)) Q:'IEN  D
 . D MES^XPDUTL("Reindexing: "_$P(^DIC(5,IEN,0),U))
 . K ^DIC(5,IEN,1,"C") ;KILL WHOLE XREF TO REMOVE ZIP CODE XREF
 . N SIEN S SIEN=0
 . F  S SIEN=$O(^DIC(5,IEN,1,SIEN)) Q:'SIEN  D
 .. N DA S DA=SIEN
 .. S DA(1)=IEN
 .. N DIK S DIK="^DIC(5,"_IEN_",1,"
 .. S DIK(1)="2^C"
 .. D EN1^DIK
 D MES^XPDUTL("Finished with reindexing.")
 ;
 ;FIX VA COUNTY CODES WHERE WE CAN
FIX D MES^XPDUTL("Looking for Counties that need VA COUNTY CODES updated...")
 ;
 D SALV ;Check to see if only the VA COUNTY CODE needs corrected
 ;
 D MES^XPDUTL("Finished updating VA COUNTY CODES.")
 ;
 D MD ;Correct DADE to MIAMI-DADE if possible
 ;
 ;CHECK COUNTY MULTIPLE FOR DUPLICATES
 D MES^XPDUTL("Checking for duplicate VA COUNTY CODES...")
 N XUSW S XUSW=0 ;ZERO IF CLEAN
 D TEST
 I XUSW F  Q:'XUSW  S XUSW=0 D MES^XPDUTL("Checking again for duplicate VA COUNTY CODES") D TEST
 D MES^XPDUTL("Finished checking for duplicate VA COUNTY CODES.")
 ;
 D SYNC ;Sync up County County multiple with file 5.13
 ;
 Q
MD ;CORRECT DADE TO MIAMI-DADE IF POSSIBLE
 N ST,CO1,CO2
 D
 . N DIERR,EM
 . S ST=+$$FIND1^DIC(5,"","X","FLORIDA","B","","EM")
 I 'ST D MES^XPDUTL("Can not find ""FLORIDA"" in your STATE(#5) file.  Installation Terminated!") Q
 D
 . N DIERR,EM
 . D FIND^DIC(5.01,","_ST_",","@;.01;2","PX","DADE","","B","","","CO1","EM")
 . D FIND^DIC(5.01,","_ST_",","@;.01;2","PX","MIAMI-DADE","","B","","","CO2","EM")
 . Q
 I +$P(CO2("DILIST",0),U)=0,+$P(CO1("DILIST",0),U)>0 D
 . ; No MIAMI-DADE in County multiple ;Edit the first DADE
 . N DIERR,FDA,EM
 . S FDA(5.01,+$P(CO1("DILIST",1,0),U)_","_ST_",",.01)="MIAMI-DADE"
 . S FDA(5.01,+$P(CO1("DILIST",1,0),U)_","_ST_",",2)="086"
 . D FILE^DIE("","FDA","EM")
 . Q
 I +$P(CO2("DILIST",0),U)=1,$P(CO2("DILIST",1,0),U,3)'="086" D
 . ;Just need to change VA COUNTY CODE
 . N DIERR,FDA,EM
 . S FDA(5.01,+$P(CO2("DILIST",1,0),U)_","_ST_",",2)="086"
 . D FILE^DIE("","FDA","EM")
 . Q
 I +$P(CO2("DILIST",0),U)>1 D
 . ;Edit all remaining MIAMI-DADEs to ZZ...
 . N VCC S VCC=999
 . F I=2:1:$P(CO2("DILIST",0),U) D
 .. N T S T=0
 .. F  S T=$O(^DIC(5,ST,1,"C",VCC,T)) Q:'T  S VCC=VCC-1,T=0
 .. N FDA,DIERR,EM
 .. S FDA(5.01,+$P(CO2("DILIST",I,0),U)_","_ST_",",.01)="ZZ"_$P(CO2("DILIST",I,0),U,2)
 .. S FDA(5.01,+$P(CO2("DILIST",I,0),U)_","_ST_",",2)=VCC
 .. D FILE^DIE("","FDA","EM")
 D  ;ADD DADE BACK IN FOR HISTORY
 . N DIERR,FDA,EM
 . S FDA(5.01,"?+1,"_ST_",",.01)="DADE"
 . S FDA(5.01,"?+1,"_ST_",",2)="025"
 . D UPDATE^DIE("","FDA","","EM")
 . Q
 Q
 ;
SYNC ;SYNC UP COUNTY MULTIPLE WITH FILE 5.13
 D EP1^XIPSYNC
LIC ;LIST INACTIVE COUNTIES
 D MES^XPDUTL("Displaying Inactivated Counties...")
 N STNM
 S STNM=""
 F  S STNM=$O(^DIC(5,"B",STNM)) Q:STNM=""  D
 . N ST,CONM
 . S ST=0,ST=$O(^DIC(5,"B",STNM,ST))
 . I +$P(^DIC(5,ST,0),U,3)>56,+$P(^(0),U,3)'=72 Q  ;NOT US STATE OR PR
 . S CONM=""
 . F  S CONM=$O(^DIC(5,ST,1,"B",CONM)) Q:CONM=""  D
 .. N CO
 .. S CO=0,CO=$O(^DIC(5,ST,1,"B",CONM,CO))
 .. I $P(^DIC(5,ST,1,CO,0),U,5)="" Q
 .. N X
 .. S X="State: "_STNM_", County: "_CONM_", County Code: "_$P(^DIC(5,ST,1,CO,0),U,3)_" Inactivated."
 .. D MES^XPDUTL(X)
 Q
 ;
TEST ;CHECK FOR DUPLICATE VA COUNTY CODES
 N ST S ST=0 ;STATE FILE IEN
 F  S ST=$O(^DIC(5,ST)) Q:'ST  D
 . I +$P(^DIC(5,ST,0),U,3)>56,+$P(^(0),U,3)'=72 Q  ;NOT US STATE OR PR
 . N FCO S FCO="" ;FIPS COUNTY VALUE
 . N VCC S VCC=999 ;START AT 999 FOR DUPLICATE COUNTY CODES
 . F  S FCO=$O(^DIC(5,ST,1,"C",FCO)) Q:FCO=""  D
 .. I $L(FCO)>3,FCO'[" " Q  ;LOOKING AT ZIP CODES
 .. N PCO S PCO=0 ;COUNTY IEN
 .. F  S PCO=$O(^DIC(5,ST,1,"C",FCO,PCO)) Q:'PCO  D
 ... N CO,VAL1,VAL2,FST,CNAME,ZZ,Z1,Z2,F1,F2,I
 ... S CO=$O(^DIC(5,ST,1,"C",FCO,PCO)) Q:'CO  D  ;IS THERE ANOTHER?
 .... S VAL1=$P(^DIC(5,ST,1,PCO,0),U)
 .... S VAL2=$P(^DIC(5,ST,1,CO,0),U)
 .... S FST=$P(^DIC(5,ST,0),U,3)
 .... ;WHICH IS CORRECT?
 .... S CNAME=VAL1 D L513 M Z1=ZZ
 .... S CNAME=VAL2 D L513 M Z2=ZZ
 .... S (F1,F2,I)=0
 .... F  S I=$O(Z1("DILIST",I)) Q:'I  I $P(Z1("DILIST",I,0),U,2)=FST_FCO S F1=1
 .... F  S I=$O(Z2("DILIST",I)) Q:'I  I $P(Z2("DILIST",I,0),U,2)=FST_FCO S F2=1
 .... I F1,'F2 S VAL="ZZ"_VAL2
 .... I 'F1,F2 S VAL="ZZ"_VAL1
 .... I 'F1,'F2 S VAL=$S($E(VAL1,1,2)'="ZZ":"ZZ"_VAL1,1:"ZZ"_VAL2)
 .... D  ;COUNTY CODE OK?
 ..... N T S T=0
 ..... F  S T=$O(^DIC(5,ST,1,"C",VCC,T)) Q:'T  S VCC=VCC-1,T=0
 .... D MES^XPDUTL("State: "_$P(^DIC(5,ST,0),U)_", County Name: "_CNAME_", VA County Code: "_FCO)
 .... D MES^XPDUTL("  Changed County Name to: "_VAL_", VA County Code to: "_VCC)
 .... N DIERR,EM
 .... S FDA(5.01,CO_","_ST_",",.01)=VAL
 .... S FDA(5.01,CO_","_ST_",",2)=VCC
 .... D FILE^DIE("","FDA","EM")
 .... S VCC=VCC-1,XUSW=1
 Q
 ;
SALV ;LET'S SEE IF ALL WE NEED TO DO IS FIX THE 'VA COUNTY CODE'
 N ST S ST=0 ;STATE FILE IEN
 F  S ST=$O(^DIC(5,ST)) Q:'ST  D
 . I +$P(^DIC(5,ST,0),U,3)>56,+$P(^(0),U,3)'=72 Q  ;NOT US STATE OR PR
 . N STV S STV=$P(^DIC(5,ST,0),U,3) ;STATE FIPS VALUE
 . N CNAME S CNAME="" ;COUNTY NAME
 .  F  S CNAME=$O(^DIC(5,ST,1,"B",CNAME)) Q:CNAME=""  D
 .. N Y
 .. N CO S CO=0  ;COUNTY IEN OF STATE FILE
 .. S CO=$O(^DIC(5,ST,1,"B",CNAME,CO))
 .. D  ;GET LIST OF POSSIBILITIES
 ... D L513
 ... I '+ZZ("DILIST",0) Q  ;CAN'T FIND COUNTY NAME
 ... N I S I=0
 ... F  S I=$O(ZZ("DILIST",I)) Q:'I  D
 .... I $E($P(ZZ("DILIST",I,0),U,2),1,2)'=STV Q  ;NOT THE STATE WE ARE LOOKING FOR
 .... N NCOV,OLDCOV,STABB,X,FDA,DIERR
 .... S NCOV=$E($P(ZZ("DILIST",I,0),U,2),3,5)
 .... S OLDCOV=$P(^DIC(5,ST,1,CO,0),U,3),STABB=$P(^DIC(5,ST,0),U,2)
 .... I OLDCOV=NCOV Q  ;COUNTY FIPS VALUES MATCH
 .... S X="Changing VA COUNTY CODE, From: "_OLDCOV_" To: "_NCOV_" County: "_CNAME_" State: "_STABB
 .... D MES^XPDUTL(X)
 .... S FDA(5.01,CO_","_ST_",",2)=NCOV
 .... D FILE^DIE("","FDA","MSG")
 Q
 ;
L513 ;GET A LIST OF COUNTIES WHO'S NAME MATCHES FROM 5.13
 N DIERR,EM
 D FIND^DIC(5.13,"","@;.01;1","PX",CNAME,"","C","","","ZZ","EM")
 Q
