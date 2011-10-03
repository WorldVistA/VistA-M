VAFHLZIC ;ALB/ESD - Creation of ZIC segment ; 7 April 93 
 ;;5.3;Registration;**122,182**;Aug 13, 1993
 ;
 ; This generic extrinsic function transfers information pertaining to
 ; a patient's individual annual income through the VA-Specific Income
 ; (ZIC) segment.
 ;
 ;
EN(VAFIEN,VAFSTR,VAFNUM) ;function returns ZIC segment containing individual annual income.
 ;
 ;  Input:
 ;         VAFIEN -- Internal entry number in the Individual Annual
 ;                   Income file.
 ;         VAFSTR -- String of fields requested separated by commas.
 ;         VAFNUM -- Set Id (sequential number-if not passed, set
 ;                   to 1).
 ;
 ;  Output:          String of components forming ZIC segment.
 ;
 ;      ****Also assumes all HL7 variables returned from****
 ;          INIT^HLTRANS are defined.
 ;
 N X,VAFNODE0,VAFNODE1,VAFNODE2,VAFNODE3,VAFY
 I $G(VAFSTR)']"" G QUIT
 S $P(VAFY,HLFS,20)="",VAFSTR=","_VAFSTR_","
 S VAFNODE0=$G(^DGMT(408.21,VAFIEN,0)),VAFNODE1=$G(^(1)),VAFNODE2=$G(^(2)),VAFNODE3=$G(^("USR"))
 S $P(VAFY,HLFS,1)=$S($G(VAFNUM):+VAFNUM\1,1:1) ; If Set Id not passed in, set to 1
 I VAFSTR[",2," S X=$P(VAFNODE0,"^",1),$P(VAFY,HLFS,2)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ) ; Income Year
 I VAFSTR[",3," S X=$P(VAFNODE0,"^",8),$P(VAFY,HLFS,3)=$S(X]"":X,1:HLQ) ; Social Security
 I VAFSTR[",4," S X=$P(VAFNODE0,"^",9),$P(VAFY,HLFS,4)=$S(X]"":X,1:HLQ) ; U.S. Civil Service
 I VAFSTR[",5," S X=$P(VAFNODE0,"^",10),$P(VAFY,HLFS,5)=$S(X]"":X,1:HLQ) ; U.S. RR Retirement
 I VAFSTR[",6," S X=$P(VAFNODE0,"^",11),$P(VAFY,HLFS,6)=$S(X]"":X,1:HLQ) ; Military Retirement
 I VAFSTR[",7," S X=$P(VAFNODE0,"^",12),$P(VAFY,HLFS,7)=$S(X]"":X,1:HLQ) ; Unemployment Compensation
 I VAFSTR[",8," S X=$P(VAFNODE0,"^",13),$P(VAFY,HLFS,8)=$S(X]"":X,1:HLQ) ; Other Retirement
 I VAFSTR[",9," S X=$P(VAFNODE0,"^",14),$P(VAFY,HLFS,9)=$S(X]"":X,1:HLQ) ; Employment Income
 I VAFSTR[",10," S X=$P(VAFNODE0,"^",15),$P(VAFY,HLFS,10)=$S(X]"":X,1:HLQ) ; Interest, Dividend, Annuity
 I VAFSTR[",11," S X=$P(VAFNODE0,"^",16),$P(VAFY,HLFS,11)=$S(X]"":X,1:HLQ) ; Workers Comp./Black Lung
 I VAFSTR[",12," S X=$P(VAFNODE0,"^",17),$P(VAFY,HLFS,12)=$S(X]"":X,1:HLQ) ; Other Income
 I VAFSTR[",13," S X=$P(VAFNODE1,"^",1),$P(VAFY,HLFS,13)=$S(X]"":X,1:HLQ) ; Medical Expenses
 I VAFSTR[",14," S X=$P(VAFNODE1,"^",2),$P(VAFY,HLFS,14)=$S(X]"":X,1:HLQ) ; Funeral and Burial Expenses
 I VAFSTR[",15," S X=$P(VAFNODE1,"^",3),$P(VAFY,HLFS,15)=$S(X]"":X,1:HLQ) ; Educational Expenses
 I VAFSTR[",16," S X=$P(VAFNODE2,"^",1),$P(VAFY,HLFS,16)=$S(X]"":X,1:HLQ) ; Cash,Amounts in Bank Accounts
 I VAFSTR[",17," S X=$P(VAFNODE2,"^",2),$P(VAFY,HLFS,17)=$S(X]"":X,1:HLQ) ; Stocks and Bonds
 I VAFSTR[",18," S X=$P(VAFNODE2,"^",3),$P(VAFY,HLFS,18)=$S(X]"":X,1:HLQ) ; Real Property
 I VAFSTR[",19," S X=$P(VAFNODE2,"^",4),$P(VAFY,HLFS,19)=$S(X]"":X,1:HLQ) ; Other Property and Assets
 I VAFSTR[",20," S X=$P(VAFNODE2,"^",5),$P(VAFY,HLFS,20)=$S(X]"":X,1:HLQ) ; Debts
 ;
QUIT Q "ZIC"_HLFS_$G(VAFY)
