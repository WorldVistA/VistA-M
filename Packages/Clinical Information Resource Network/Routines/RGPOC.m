RGPOC ;BIR/PTD-ADD/EDIT POINT OF CONTACT OPTION ;8/22/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**21,24**;30 Apr 99
 ;
 ;Reference to ^VA(200, supported by IA #2589
 ;Reference to LINK^HLUTIL3 and $$GET1^DIQ(870 supported by IA #3335
 ;Reference to DOMAIN (#4.2) file supported by IA #3452
 ;
INTRO ;Introduction to Option
 W @IOF,!,"This option allows you to transmit information to the MPI/PD Data"
 W !,"Management team so that the Point of Contact website can be updated."
 W !!,"To obtain a list of MPI/PD Points of Contact for each facility,"
 W !,"look for the POC web link on the MPI/PD Home Page."
 W !!,"The COMMERCIAL PHONE (#.135) field in the NEW PERSON (#200) file"
 W !,"will only accept numbers and punctuation, 4-20 characters."
 W !!,"Please include the entire phone number:",!,"area code, 7 digit number and extension (e.g., AAA NNN NNNN XXXX)"
 W !!,"A contact name without a phone number will NOT be transmitted."
 W !,"                                           ==="
 ;
ASK ;Select POC to add/edit.
 W ! K DIR S DIR(0)="LA^1:7"
 S DIR("A")="Which Point of Contact information do you wish to update? "
 S DIR("A",1)="Select one or more of the following:"
 S DIR("A",2)="(A list or range of numbers can be entered, e.g., 1,3 or 2-4,6.)"
 S DIR("A",3)=""
 S DIR("A",4)="    1 - Admin POC     2 - Alt Admin POC     3 - IRM POC     4 - Alt IRM POC"
 S DIR("A",5)="    5 - HL7 POC       6 - Alt HL7 POC       7 - ALL POCs"
 S DIR("A",6)=""
 S DIR("B")="7"
 S DIR("?",1)="Enter:"
 S DIR("?",2)=" ""1"" to add/edit Administrative Point of Contact."
 S DIR("?",3)=" ""2"" to add/edit Alternate Administrative Point of Contact."
 S DIR("?",4)=" ""3"" to add/edit IRM Point of Contact."
 S DIR("?",5)=" ""4"" to add/edit Alternate IRM Point of Contact."
 S DIR("?",6)=" ""5"" to add/edit Health Level Seven Point of Contact."
 S DIR("?",7)=" ""6"" to add/edit Alternate Health Level Seven Point of Contact."
 S DIR("?",8)=" ""7"" to add/edit ALL Points of Contact."
 S DIR("?")=" You can enter a list or range of numbers, e.g., 1,3,5 or 1-3,6."
 D ^DIR G:$D(DIRUT) END S RGANS=$S(Y[7:7,1:Y)
 ;
MAIN ;Direct flow based on variable RGANS.
 S RGQUIT=0
 I RGANS["1" D POC1^RGPOC1
 I RGANS["2" D POC2^RGPOC1
 I RGANS["3" D POC3^RGPOC1
 I RGANS["4" D POC4^RGPOC1
 I RGANS["5" D POC5^RGPOC1
 I RGANS["6" D POC6^RGPOC1
 I RGANS="7" S (RGADMOFN,RGAD2OFN,RGIRMOFN,RGIR2OFN,RGHL7OFN)="" D
 .D POC1^RGPOC1 Q:RGADMONM=-1  Q:RGADMOFN=-1
 .D POC2^RGPOC1 Q:RGAD2ONM=-1  Q:RGAD2OFN=-1
 .D POC3^RGPOC1 Q:RGIRMONM=-1  Q:RGIRMOFN=-1
 .D POC4^RGPOC1 Q:RGIR2ONM=-1  Q:RGIR2OFN=-1
 .D POC5^RGPOC1 Q:RGHL7ONM=-1  Q:RGHL7OFN=-1
 .D POC6^RGPOC1
 D SEND
AGAIN ;Return to selection prompt?
 I RGQUIT=1 D END Q
 W ! K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to add/edit another contact"
 D ^DIR I +Y=1 D END W @IOF G ASK
 D END
 Q
 ;
SEND ;Send message to Data Management Team
 Q:'$O(RGARRAY(0))
 ;Display changed fields.
 W @IOF,!,"The following data will be transmitted to the MPI/PD Data Management team.",!
 S RGNUM=0
 F  S RGNUM=$O(RGARRAY(RGNUM)) Q:'RGNUM  W !,RGARRAY(RGNUM)
 ;
DOMAIN ;Determine test or production account (production must have
 ;"MPI-AUSTIN.VA.GOV" domain for logical link "MPIVA").
 ;Get logical link IEN for "MPIVA".
 ;Get domain for "MPIVA" logical link in HL LOGICAL LINK (#870) file.
 N RGDOMAIN,RGDMNC S RGDOMAIN=""
 D LINK^HLUTIL3("200M",.HLL,"I")
 S IEN=$O(HLL(0)) I +IEN>0 S RGDOMAIN=$$GET1^DIQ(870,+IEN_",",.03)
 S RGDMNC=$$FIND1^DIC(4.2,"","MQ","MPI-AUSTIN.VA.GOV") I RGDMNC>0 S RGDMNC=$$GET1^DIQ(4.2,RGDMNC_",",.01)
 I RGDOMAIN="" Q
 I RGDOMAIN'=RGDMNC W !!,"No data will be transmitted from a TEST account." Q  ;Not production; quit SEND.
 ;
 ;Transmit e-mail message.
 S XMSUB="POINT OF CONTACT CHANGE - SITE "_$P($$SITE^VASITE(),"^",3)
 S XMDUZ=DUZ ;name of person editing the option
 S XMY("G.MPI/PD POC UPDATE@MPI-AUSTIN.MED.VA.GOV")=""
 S XMTEXT="RGARRAY("
 ;
 S RGARRAY(1)="There has been a change in the point of contact information from"
 S RGARRAY(2)=$P($$SITE^VASITE(),"^",2)_" (station number "_$P($$SITE^VASITE(),"^",3)_")."
 S RGARRAY(3)=""
 D ^XMD
 W !!,"Sending information to the MPI/PD Data Management team now.",!
 Q
 ;
END ;Kill variables 
 K DA,DIC,DIE,DIR,DIRUT,DR,DTOUT,HLL,IEN,RGAD2NFN,RGAD2NNM,RGAD2OFN,RGAD2ONM,RGADMNFN
 K RGADMNNM,RGADMOFN,RGADMONM,RGANS,RGARRAY,RGDATA,RGDOMAIN,RGHL2NFN,RGHL2NNM,RGHL2OFN
 K RGHL2ONM,RGHL7NFN,RGHL7NNM,RGHL7OFN,RGHL7ONM,RGIR2NFN,RGIR2NNM,RGIR2OFN,RGIR2ONM
 K RGIRMNFN,RGIRMNNM,RGIRMOFN,RGIRMONM,RGNUM,RGQUIT,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 Q
 ;
NAME(RGPC,RGFLD) ;Edit IEN of POC from CIRN SITE PARAMETER (#991.8) file.
 ;RGPC -  piece number of POC on the ^RGSITE(991.8,1,"POC" node
 ;RGFLD - field number of POC to be used in the DR string
 ;Returns POC IEN before edit^POC IEN after edit OR -1^error message
 ;
 N RGOLDNAM,RGNEWNAM
 S RGOLDNAM=$P($G(^RGSITE(991.8,1,"POC")),"^",RGPC)
 L +^RGSITE(991.8):10
 S DIE="^RGSITE(991.8,",DA=1,DR=RGFLD
 D ^DIE K DA,DIE,DR
 L -^RGSITE(991.8)
 I $D(DTOUT)&(RGOLDNAM="") Q "-1^USER TIMED OUT"
 I $D(Y) Q "-1^USER UP-ARROWED OUT"
 S RGNEWNAM=$P($G(^RGSITE(991.8,1,"POC")),"^",RGPC)
 Q RGOLDNAM_"^"_RGNEWNAM
 ;
PHONE(RGIEN) ;Edit POC COMMERCIAL PHONE (#.135) from NEW PERSON (#200) file.
 ;Supported IA #10060 allows read/FileMan for all fields in ^VA(200
 ;RGIEN - IEN for NEW PERSON for whom phone number is needed
 ;Returns POC COMMERCIAL PHONE before edit^POC COMMERCIAL PHONE after edit
 ;
 N RGOLDFON,RGNEWFON
 S RGOLDFON=$$GET1^DIQ(200,RGIEN,.135)
 S RGOLDFON=$TR(RGOLDFON,",./<>?;:'[]\{}|`~!@#$%^&*-_=+","                              ")
 S RGOLDFON=$TR(RGOLDFON,"()","")
 ;Edit COMMERCIAL PHONE (#.135), NEW PERSON (#200) file
 ;IA #2589 allows write/FileMan to field .135 in ^VA(200,
 L +^VA(200,RGIEN):10
 S DIE="^VA(200,",DA=RGIEN,DR=.135
 D ^DIE K DA,DIE,DR
 L -^VA(200,RGIEN)
 I $D(DTOUT)&(RGOLDFON="") Q "-1^USER TIMED OUT"
 I $D(Y) Q "-1^USER UP-ARROWED OUT"
 S RGNEWFON=$$GET1^DIQ(200,RGIEN,.135)
 S RGNEWFON=$TR(RGNEWFON,",./<>?;:'[]\{}|`~!@#$%^&*-_=+","                             ")
 S RGNEWFON=$TR(RGNEWFON,"()","")
 Q RGOLDFON_"^"_RGNEWFON
 ;
CNVRTNM(NAME) ;Convert IEN from NEW PERSON (#200) to printable name
 ;NAME - ien for POC
 N RGNAME
 I NAME="" Q "<NULL>"
 S RGNAME=$$GET1^DIQ(200,NAME,.01)
 Q RGNAME
 ;
ERROR1(RGPOC) ;Write error message 1 for type POC.
 W !!,"No "_RGPOC_" Point of Contact identified."
 Q
 ;
ERROR2(RGPOC,RGFLD,RGOLDNAM,RGNEWNAM) ;Write error message 2 for type POC.
 W !!,"No "_RGPOC_" Point of Contact phone number identified."
 ;User timed out or up-arrowed out on phone number.
 ;Restore name value to original value, if value changed.
 I RGOLDNAM=RGNEWNAM K RGFLD,RGOLDNAM,RGNEWNAM,RGPOC Q
 L +^RGSITE(991.8):10
 S DIE="^RGSITE(991.8,",DA=1,DR=RGFLD_"///^S X=$S(RGOLDNAM="""":""@"",1:RGOLDNAM)"
 D ^DIE
 L -^RGSITE(991.8)
 K DA,DIE,DR,RGFLD,RGOLDNAM
 W !,RGPOC_" Point of Contact restored to original value."
 Q
 ;
