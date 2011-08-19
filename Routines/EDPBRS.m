EDPBRS ;SLC/KCM - Reset Board Configuration
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
RESET(AREA) ; Set initial configuration for site & area
 D SPEC(AREA),COLOR(AREA),ROOMS(AREA),PARAMS(AREA)
 S ^EDPB(231.9,AREA,231)=$H
 Q
SPEC(AREA) ; Set up default board spec
 ; assumes site, area passed in
 N I,X,WP,MSG
 F I=1:1 S X=$P($T(BRDXML+I),";",3,99) Q:$E(X,1,5)="zzzzz"  S WP(I)=X
 D UPDBRD^EDPBCF(AREA,0,"Main (default)",.WP,.MSG)
 Q
BRDXML ; XML for the board spec
 ;;<row color="stsAcuity"/>
 ;;<displayProperties fontSize="10" displayWidth="1024" displayLabel="1024x768" scrollDelay="7" />
 ;;<col att="@bedNm" header="Room" color="" width="48" label="Room / Bed"/>
 ;;<col att="@last4" header="Patient" color="" width="58" label="Patient X9999"/>
 ;;<col att="@complaint" header="Complaint" color="" width="406" label="Complaint"/>
 ;;<col att="@mdNm" header="Prv" color="" width="51" label="Provider Initials"/>
 ;;<col att="@resNm" header="Res" color="" width="51" label="Resident Initials"/>
 ;;<col att="@rnNm" header="RN" color="" width="51" label="Nurse Initials"/>
 ;;<col att="@acuityNm" header="Acuity" color="" width="51" label="Acuity"/>
 ;;<col att="@emins" header="E Mins" color="" width="51" label="Total Minutes"/>
 ;;<col att="@lab" header="L" color="labUrg" width="51" label="Lab Active/Complete"/>
 ;;<col att="@rad" header="I" color="radUrg" width="61" label="Imaging Active/Complete"/>
 ;;zzzzz
 ;;
COLOR(AREA) ; Set up default colors
 N I,X,WP
 F I=1:1 S X=$P($T(CLRXML+I),";",3,99) Q:$E(X,1,5)="zzzzz"  S WP(I)=X
 D WP^DIE(231.9,AREA_",",3,"","WP")
 I $D(DIERR) W !,"spec update failed"
 D CLEAN^DILF
 Q
CLRXML ; XML for the color spec
 ;;<colors id="stsAcuity" type="val" >
 ;;<map att="@status" clr="1,0xffffff,0x808000" val="8" />
 ;;<map att="@status" clr="0" val="9" />
 ;;<map att="@status" clr="0" val="10" />
 ;;<map att="@status" clr="0" val="11" />
 ;;<map att="@status" clr="1,0xffffff,0x800000" val="12" />
 ;;<map att="@status" clr="1,0x000000,0xfffbf0" val="13" />
 ;;<map att="@status" clr="1,0xff0000,0xc0dcc0" val="14" />
 ;;<map att="@acuity" clr="1,0x000000,0xff0000" val="1" />
 ;;<map att="@acuity" clr="1,0xffffff,0x0000ff" val="2" />
 ;;<map att="@acuity" clr="1,0x000000,0xff00ff" val="3" />
 ;;<map att="@acuity" clr="1,0x000000,0x00ff00" val="4" />
 ;;<map att="@acuity" clr="0" nm="5" val="5" />
 ;;</colors>
 ;;<colors id="labUrg" nm="Urgency - Lab" type="val" >
 ;;<map att="@labUrg" clr="1,0x000000,0x00ff00" val="0" />
 ;;<map att="@labUrg" clr="1,0x000000,0xffff00" val="1" />
 ;;<map att="@labUrg" clr="1,0x000000,0xff0000" val="2" />
 ;;</colors>
 ;;<colors id="radUrg" nm="Urgency - Radiology" type="val" >
 ;;<map att="@radUrg" clr="1,0x000000,0x00ff00" val="0" />
 ;;<map att="@radUrg" clr="1,0x000000,0xffff00" val="1" />
 ;;<map att="@radUrg" clr="1,0x000000,0xff0000" val="2" />
 ;;</colors>
 ;;zzzzz
 ;;
ROOMS(AREA) ; baseline rooms
 N I,X
 F I=1:1 S X=$P($T(ROOMLST+I),";",3,99) Q:$E(X,1,5)="zzzzz"  D
 . N FDA,FDAIEN,DIERR,ERR
 . S FDA(231.8,"+1,",.01)=$P(X,U)
 . S FDA(231.8,"+1,",.02)=EDPSITE
 . S FDA(231.8,"+1,",.03)=AREA
 . S FDA(231.8,"+1,",.05)=$P(X,U,3)
 . S FDA(231.8,"+1,",.06)=$P(X,U,2)
 . S FDA(231.8,"+1,",.07)=$P(X,U,4)
 . S FDA(231.8,"+1,",.09)=$P(X,U,5)
 . D UPDATE^DIE("","FDA","FDAIEN","ERR")
 D CLEAN^DILF
 Q
ROOMLST ; Name^Display Name^Seq^When^Category
 ;;Waiting^WAIT^1^0^2
 ;;Ambulance^AMBU^5^0^1
 ;;Hallway^HALL^10^0^1
 ;;General Radiology^RAD^110^0^1
 ;;CT^CT^120^0^1
 ;;MRI^MRI^130^0^1
 ;;Cardiac Cath^CATH^140^0^1
 ;;Cardiac Stress Test^STEST^150^0^1
 ;;Dialysis^DIAL^160^0^1
 ;;Subspecialty Clinic^SCLIN^170^0^1
 ;;zzzzz
PARAMS(AREA) ; baseline parameters
 N FDA,DIERR
 S AREA=AREA_","
 S FDA(231.9,AREA,1.1)=1
 S FDA(231.9,AREA,1.2)=1
 S FDA(231.9,AREA,1.3)=1
 S FDA(231.9,AREA,1.4)=1
 S FDA(231.9,AREA,1.5)=300
 S FDA(231.9,AREA,1.6)=420
 S FDA(231.9,AREA,1.7)=480
 S FDA(231.9,AREA,1.8)=1
 S FDA(231.9,AREA,1.11)=$O(^EDPB(231.8,"AC",EDPSITE,+AREA,"AMBU",0))
 S FDA(231.9,AREA,1.12)=$O(^EDPB(231.8,"AC",EDPSITE,+AREA,"WAIT",0))
 D FILE^DIE("","FDA","ERR")
 D CLEAN^DILF
 Q
