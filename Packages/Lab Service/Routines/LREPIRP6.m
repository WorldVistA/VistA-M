LREPIRP6 ;DALOI/CKA-EMERGING PATHOGENS DETAILED VERIFICATION REPORT ;5/14/2003
 ;;5.2;LAB SERVICE;**281**;Sep 27, 1994
 ; Reference to ^DIC(21 supported by IA #2504
 Q
 ;HEADINGS of 1,3,4,5,6,8,10,18,19,20,21,22,23
 ;Save in ^XTMP("LREPIREP"_date,path,"HDG",#)
CDT(DATE) ;CONVERTS THE DATE AND TIME
 S X=$E(DATE,5,6)_"-"_$E(DATE,7,8)_"-"_$E(DATE,1,4)
 S:$E(DATE,9,12)'="" X=X_"@"_$E(DATE,9,12)
 S:X="--" X=""
 Q X
HDGS ;1-VANCOMYCIN-RESISTANT ENTEROCOCCUS
 S ^XTMP("LREPIREP"_LRDATE,1,"HDG",1)="NTE~1-Report of Vancomycin-resistant Enterococcus"
 S ^XTMP("LREPIREP"_LRDATE,1,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,1,"HDG",3)="result for Vancomycin-resistant Enterococcus.  Identifying information, along "
 S ^XTMP("LREPIREP"_LRDATE,1,"HDG",4)="with specimen and culture results have been provided."
 ;
 ;3-PENICILLIN-RESISTANT STREPTOCOCCUS PNEUMONIAE
 S ^XTMP("LREPIREP"_LRDATE,3,"HDG",1)="NTE~3-Report of Pencillin-resistant Streptococcus pneumoniae"
 S ^XTMP("LREPIREP"_LRDATE,3,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,3,"HDG",3)="result for Penicillin-resistant Streptococcus pneumoniae.  Identifying"
 S ^XTMP("LREPIREP"_LRDATE,3,"HDG",4)=" information, along with specimen and culture results have been provided."
 ;
 ;4-clostridium difficile
 S ^XTMP("LREPIREP"_LRDATE,4,"HDG",1)="NTE~4-Report of Clostridium difficile"
 S ^XTMP("LREPIREP"_LRDATE,4,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,4,"HDG",3)="result for Clostridium difficile.  Identifying information, along "
 S ^XTMP("LREPIREP"_LRDATE,4,"HDG",4)="with specimen and culture results have been provided."
 ;
 ;5-TUBERCULOSIS
 S ^XTMP("LREPIREP"_LRDATE,5,"HDG",1)="NTE~5-Report of Tuberculosis"
 S ^XTMP("LREPIREP"_LRDATE,5,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,5,"HDG",3)="result for Mycobacterium tuberculosis.  Identifying information, along "
 S ^XTMP("LREPIREP"_LRDATE,5,"HDG",4)="with specimen and culture results have been provided."
 ;
 ;6-Group A Streptococcus
 S ^XTMP("LREPIREP"_LRDATE,6,"HDG",1)="NTE~6-Report of Group A Streptococcus"
 S ^XTMP("LREPIREP"_LRDATE,6,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,6,"HDG",3)="result for Group A Streptococcus.  Identifying information, along "
 S ^XTMP("LREPIREP"_LRDATE,6,"HDG",4)="with specimen and culture results have been provided."
 ;
 ;8 - Candida Bloodstream Infections
 S ^XTMP("LREPIREP"_LRDATE,8,"HDG",1)="NTE~8-Report of Candida bloodstream infections"
 S ^XTMP("LREPIREP"_LRDATE,8,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,8,"HDG",3)="result for Candida (or other yeast) bloodstream infections.  Identifying"
 S ^XTMP("LREPIREP"_LRDATE,8,"HDG",4)="information, along with specimen and culture results have been provided."
 ;
 ;10- Escherichia coli O157
 S ^XTMP("LREPIREP"_LRDATE,10,"HDG",1)="NTE~10-Report of Escherichia coli O157"
 S ^XTMP("LREPIREP"_LRDATE,10,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,10,"HDG",3)="result for Escherichia coli serotype O157.  Identifying information, along "
 S ^XTMP("LREPIREP"_LRDATE,10,"HDG",4)="with specimen and culture results have been provided."
 ;18-All Staphylococcus aureus
 S ^XTMP("LREPIREP"_LRDATE,18,"HDG",1)="NTE~18-Report of All Staphylococcus aureus"
 S ^XTMP("LREPIREP"_LRDATE,18,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,18,"HDG",3)="result for all Staphylococcus aureus.  Identifying information, along "
 S ^XTMP("LREPIREP"_LRDATE,18,"HDG",4)="with specimen and culture results have been provided."
 ;19-Methicillin-resistant Staphylococcus aureus
 S ^XTMP("LREPIREP"_LRDATE,19,"HDG",1)="NTE~19-Report of methicillin-resistant Staphylococcus"
 S ^XTMP("LREPIREP"_LRDATE,19,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,19,"HDG",3)="result for methicillin-resistant Staphylococcus aureus.  Identifying"
 S ^XTMP("LREPIREP"_LRDATE,19,"HDG",4)="information, along with specimen and culture results have been provided."
 ;20-Vancomycin-resistant Staphylococcus aureus
 S ^XTMP("LREPIREP"_LRDATE,20,"HDG",1)="NTE~20-Vancomycin-resistant Staphylococcus aureus"
 S ^XTMP("LREPIREP"_LRDATE,20,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,20,"HDG",3)="result for Vancomycin-resistant Staphylococcus aureus.  Identifying information,"
 S ^XTMP("LREPIREP"_LRDATE,20,"HDG",4)="along with specimen and culture results have been provided."
 ;
 ;21-Vancomycin-resistant coagulase negative Staphylococcus
 S ^XTMP("LREPIREP"_LRDATE,21,"HDG",1)="NTE~21-Vancomycin-resistant coagulase negative Staphylococcus"
 S ^XTMP("LREPIREP"_LRDATE,21,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,21,"HDG",3)="result for Vancomycin-resistant coagulase negative staphylococcus.  Identifying"
 S ^XTMP("LREPIREP"_LRDATE,21,"HDG",4)="information, along with specimen and culture results have been provided."
 ;
 ;22-All Streptococcus pneumoniae
 S ^XTMP("LREPIREP"_LRDATE,22,"HDG",1)="NTE~22-All Streptococcus pneumoniae"
 S ^XTMP("LREPIREP"_LRDATE,22,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,22,"HDG",3)="result for all Streptococcus pneumoniae.  Identifying information, along "
 S ^XTMP("LREPIREP"_LRDATE,22,"HDG",4)="with specimen and culture results have been provided."
 ;
 ;23- All enterococci
 S ^XTMP("LREPIREP"_LRDATE,23,"HDG",1)="NTE~23- All Enterococci"
 S ^XTMP("LREPIREP"_LRDATE,23,"HDG",2)="These data note persons at your facility during the month who had a positive"
 S ^XTMP("LREPIREP"_LRDATE,23,"HDG",3)="result for all Enterococci.  Identifying information, along "
 S ^XTMP("LREPIREP"_LRDATE,23,"HDG",4)="with specimen and culture results have been provided."
 ;
 Q
