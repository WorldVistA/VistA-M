LRMITSEC ;SLC/STAFF - MICRO TREND ENTRY COMPREHENSIVE ;10/19/92  10:08
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ; from LRMITSE
 ;
 D COMP K DIC,DIR,LRDN,X,Y
 Q
COMP W !!?10,"Criteria for all reports."
 ; organism type
 W ! K DIR S DIR(0)="LA^1:5",DIR("A")="Select the numbers: ",DIR("B")="" F LRX="B^1","F^2","M^3","P^4","V^5" I $D(LROTYPE($P(LRX,U))) S DIR("B")=DIR("B")_$P(LRX,U,2)_$S($L($O(LROTYPE(LRX))):",",1:"")
 K LROTYPE,LRX
 S DIR("A",1)="Enter the types of organisms used for all reports."
 S DIR("A",2)="1) Bacteria, 2) Fungus, 3) Mycobacteria, 4) Parasite, 5) Virus"
 S DIR("?")="Enter numbers for each type of organism to be included on the reports.",DIR("??")=LRHELP
 S DIR("?",1)="Enter a number, numbers separated by commas, and/or a range of numbers"
 S DIR("?",2)="ex: 1 or 1,3,5 or 1,3-5 or 1-5"
 D ^DIR I $D(DIRUT) S LREND=1 Q
 S:Y[1 LROTYPE("B")="" S:Y[2 LROTYPE("F")="" S:Y[3 LROTYPE("M")="" S:Y[4 LROTYPE("P")="" S:Y[5 LROTYPE("V")=""
 ; specific organisms
 W ! K DIR S DIR(0)="Y",DIR("A")="Will all reports be for specific organisms",DIR("B")="NO"
 S DIR("?")="Enter 'Y'es or 'N'o.",DIR("??")=LRHELP
 S DIR("?",1)="Do you want all antibiotic trend data for just selected organisms?"
 S DIR("?",2)="This would apply to all types of reports."
 D ^DIR I $D(DIRUT) S LREND=1 Q
 I Y=1 D  Q:LREND
 .K DIC S DIC=61.2,DIC(0)="AEMOQZ",DIC("A")="Select Organism: ",DIC("S")="I $L($P(^(0),U,5)),$D(LROTYPE($P(^(0),U,5)))"
 .K LRM("O"),LRSORG F  D ^DIC Q:Y<1  S LRM("O","S",+Y)=$P(Y,U,2),LRSORG($P(Y(0),U,5),+Y)=""
 .I $D(DTOUT) S LREND=1
 ; length of stay
 W ! K DIR S DIR(0)="NA^0:30",DIR("A")="Enter length of stay (days): ",DIR("B")=LRLOS
 S DIR("A",1)="Number of days from patient's admission date to collection date of specimen"
 S DIR("A",2)="to be excluded from all reports."
 S DIR("?")="Enter the number of days.",DIR("??")=LRHELP
 S DIR("?",1)="Collections taken before this many days from admission would be excluded."
 S DIR("?",2)="Outpatients would also be excluded."
 D ^DIR I $D(DIRUT) S LREND=1 Q
 S LRLOS=Y
 ; antibiotic pattern
 I $D(LROTYPE("B")) D  Q:LREND
 .W ! K DIR,LRAP S DIR(0)="Y",DIR("A")="Will all reports require a specific antibiotic pattern",DIR("B")="NO"
 .S DIR("?")="Enter 'Y'es or 'N'o.",DIR("??")=LRHELP
 .S DIR("?",1)="You may restrict all reports to only those that have specific antibiotic"
 .S DIR("?",2)="interpretations."
 .D ^DIR I $D(DIRUT) S LREND=1 Q
 .I Y=1 D  Q:LREND
 ..K DIC S DIC=62.06,DIC(0)="AEMOQZ",DIC("A")="Select Antibiotic: ",DIC("S")="I +$P(^(0),U,2),$L($P(^(0),U,5))"
 ..F  D ^DIC Q:Y<1  S LRDN=$P(Y(0),U,2) D  Q:LREND
 ...K DIR S DIR(0)="SAM^S:Susceptible;R:Resistant",DIR("A")="Select Interpretation: "
 ...S DIR("?")="Enter 'S' or 'R'.",DIR("??")=LRHELP
 ...S DIR("?",1)="Interpretations are evaluated as only S or R."
 ...S DIR("?",2)="Interpretations of 'I' are counted as 'R'."
 ...S DIR("?",3)="Interpretations of 'MS' are counted as 'S'."
 ...D ^DIR I $D(DIRUT) S LREND=1 Q
 ...S LRAP(LRDN)=Y
 ..I $D(DTOUT) S LREND=1
 ; merge criteria
 S:'$D(LROTYPE("B")) LRMERGE="N" I $D(LROTYPE("B")) D  Q:LREND
 .W !!,"Merge criteria for all reports."
 .K DIR S DIR(0)="SAM^N:No Merge;S:Specimen;C:Collection sample;A:Any sample",DIR("A")="(N)o merge, (S)pecimen, (C)ollection sample, or (A)ny sample: ",DIR("B")=LRMERGE
 .S DIR("?")="Enter 'N'o merge, 'S'pecimen, 'C'olection sample, or 'A'ny sample.",DIR("??")=LRHELP
 .S DIR("?",1)="Isolates from the same patient of the same organism can be merged."
 .S DIR("?",2)="Merged isolates are only counted once."
 .D ^DIR I $D(DIRUT) S LREND=1 Q
 .S LRMERGE=Y
 ; detailed report
 W ! K DIR S DIR(0)="Y",DIR("A")="Include detailed patient results on all reports",DIR("B")=$S(LRDETAIL:"YES",1:"NO")
 S DIR("?")="Enter 'Y'es or 'N'o.",DIR("??")=LRHELP
 S DIR("?",1)="A detailed report includes specific information on all isolates."
 S DIR("?",2)="It can be useful in confirming the counts on the trend report."
 S DIR("?",3)="This printout is much longer than the usual report."
 D ^DIR I $D(DIRUT) S LREND=1 Q
 S LRDETAIL=$S(Y:1,1:0)
 Q
