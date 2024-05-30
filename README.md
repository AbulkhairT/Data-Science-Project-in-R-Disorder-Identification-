Report:


By:

Turmakhanov Abulkhair
Wentao Li


Preprocessing: 

•	We first cleaned and preprocessed the data. We filled in missing values and removed duplicates, we then removed variables with near zero variance because they are not very useful for the models. So we used nearZeroVar function to exclude these values from analysis. 

•	After that we found columns with more than 80% of missing values and imputed means instead of them. Lastly, we transformed the class variable into a factor, where Y is yes and N is no. It was important for classification purposes. 

Balancing the data: 

•	We used 2 different methods for balancing the data. Oversampling the minority class and Undersampling the Majority class. One works by replicating the minority class to match the number of majority class samples and the other one reduces the number of samples in the majority class to match the minority class size. 

•	Undersampling technique undersamples the majority class N and matches the minority class size Y. That way the dataset is reduced by randomly selecting majority class group, trying to move values of the model’s accuracy and bias towards frequently occurring class. 

•	Oversampling technique replicates minority values to match the majority class, that way it tries to create balanced dataset. This technique could improve sensitivity and accuracy. 

•	We used these strategies to solve imbalances, which further would solve the issue of bias the model’s performance towards the majority class

Feature selection methods: 
•	We used three different feature selectors, they are: Boruto, Information Gain and RFE.  They all use different techniques of getting the best feature selections.
•	The Boruta found 76 attributes as important and 87 as not important and left 27 tentative. Only variables with huge impact on predicting the outcome were taken into consideration when using Boruta. 

•	For the Information Gain, Top five variables were: 'DECIDE', 'PHYSHLTH', 'GENHLTH', 'X_PHYS14D', and 'EMPLOY1'. This function focused on variables that give most valuable information about class variable and tries to improve accuracy of prediction. 
 

•	RFE chose 5 variables which are: 'DECIDE', 'DIFFALON', 'GENHLTH', 'X_PHYS14D', and 'PHYSHLTH'. This function tries to optimize the feature set by deleting variables which are not as significant to the model and tries to make the model as efficient as it could. 
 


Data Mining Procedure:

•	To collect the date, analyze it and get useful insights out of it we performed different steps. Here is the process:

•	First, we gathered and combined data, we made sure to gather the given dataset, and analyzed it. From the challenges, it was a new dataset which we had no idea how to work with, certain variables needed special attention because some algorithms would only take into consideration numerical values, whereas the target variable was not numerical. 

•	We then preprocessed and cleaned data, here we managed absent values, eliminated redundant information and rectificated data errors. That was done to improve the accuracy of models. 

•	We used different methods, to make sure that the data can be used and is of high quality, we imputed missing values, handled outliers, transformed data, meaning aggregated and normalized it. 
•	We later used three feature selectors, Boruta, Information Gain and RFE to reduce the dimensionality of the dataset we used. By focusing on the most important features, we decreased the time it would take to run the algorithm and improved the accuracy of models. 
•	Model Selection and training: out of 36 combinations we could have possibly had, we chose the best performing algorithms based on factors such as: TPR, FPR, Precision, Recall, F-Measure, ROC, MCC, Kappa. The dataset was then used to train these models. 
•	To validate models, we divided the training and testing data, and used cross validation techniques to make sure the models were robust. 
•	The main goal was to understand performance of different features, balancing method, and different algorithms on the same dataset.
Algorithms used and Results:  
We used 6 different classification algorithms, they are: 
•	Logistic Regression
•	Naïve Bayes
•	Decision Tree
•	Random Forest
•	GBM
•	SVM

Logistic Regression

Logistic regression: 
Oversampling, Boruta


	N	Y
N	785	159
Y	24	31

	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.97	0.265	0.956	1	0.977	0.788	NA	0.448
								
Class 1	0.954	0.284	1	0.954	0.976	0.788	NA	0.448
								
Wt. Average	0.747	0.29	0.715	0.747	0.731	0.977	NA	0.95

Logistic regression: 
Undersampling, Boruta

	N	Y
N	792	150
Y	17	40



	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.970	0.02	0.956	0.97	0.977	0.59	0.32	0.25
								
Class 1	0.21	0.78	0.70	0.21	0.32	0.59	0.32	0.25
								
Wt. Average	0.802		0.81	0.83	0.79	0.59	0.32	0.25


Logistic regression: 
Oversampling, Information Gain 

	N	Y
N	785	148
Y	24	42

	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.970	0.265	0.956	1	0.977	0.788	NA	0.448
								
Class 1	0.029	0.284	1	0.954	0.976	0.788	NA	0.448
								
Wt. Average		0.299		0.747	0.731	0.977	NA	0.95


Logistic regression: 
Undersampling, Information Gain


	N	Y
N	779	145
Y	30	45


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.96	0.03	0.84	0.96	0.901	0.595	0.302	0.255
								
Class 1	0.221	0.778	0.636	0.221	0.328	0.595	0.302	0.255
								
Wt. Average	0.747		0.80	0.82	0.792	0.595	0.302	0.255

Logistic regression: 
Oversampling, RFE 

	N	Y
N	783	149
Y	26	41


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.96	0.03	0.84	0.96	0.89	0.59	0.28	0.24
								
Class 1	0.221	0.78	0.61	0.82	0.78	0.59	0.28	0.24
								
Wt. Average			0.79	0.82	0.78	0.59	0.28	0.24

Logistic regression: 
Undersampling, RFE

	N	Y
N	782	143
Y	27	47


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.96	0.03	0.84	0.96	0.89	0.60	0.32	0.27
								
Class 1	0.24	0.75	0.63	0.24	0.78	0.60	0.32	0.27
								
Wt. Average			0.80	0.82	0.79	0.60	0.32	0.27
Recall and precision for Logistic Regression were high in general. The ROC region showed a moderate degree of class distinction. Low values were indicated by the MCC and Kappa values.

Naïve Bayes

Naïve Bayes: 
Oversampling, Boruta 

	N	Y
N	661	103
Y	148	87


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.720	0.279	0.660	0.720	0.689	0.673	0.348	0.346
								
Class 1	0.625	0.374	0.689	0.625	0.656	0.673	0.348	0.346
								
Wt. Average			0.674	0.673	0.672	0.673	0.348	0.346


Naïve Bayes: 
Undersampling, Boruta 

	N	Y
N	680	101
Y	129	89


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.84	0.15	0.87	0.84	0.85	0.65	0.29	0.29
								
Class 1	0.46	0.53	0.40	0.46	0.43	0.65	0.29	0.29
								
Wt. Average			0.78	0.76	0.77	0.65	0.29	0.29


Naïve Bayes: 
Oversampling, Information Gain 

	N	Y
N	667	102
Y	142	88


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.82	0.17	0.86	0.82	0.84	0.64	0.26	0.26
								
Class 1	0.46	0.53	0.38	0.46	0.41	0.64	0.26	0.26
								
Wt. Average			0.77	0.75	0.76	0.64	0.26	0.26


Naïve Bayes: 
Undersampling, Information Gain 

	N	Y
N	671	91
Y	138	99


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.82	0.17	0.88	0.82	0.85	0.67	0.32	0.32
								
Class 1	0.46	0.53	0.41	0.52	0.46	0.67	0.32	0.32
								
Wt. Average			0.79	0.77	0.67	0.67	0.32	0.32



Naïve Bayes: 
Oversampling, RFE 

	N	Y
N	650	103
Y	159	87


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.80	0.19	0.86	0.80	0.83	0.63	0.23	0.23
								
Class 1	0.45	0.54	0.35	0.45	0.39	0.63	0.23	0.23
								
Wt. Average			0.76	0.73	0.74	0.63	0.23	0.23


Naïve Bayes: 
Undersampling, RFE

	N	Y
N	689	95
Y	120	95


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.85	0.14	0.87	0.85	0.86	0.67	0.33	0.33
								
Class 1	0.5	0.53	0.44	0.5	0.46	0.67	0.33	0.33
								
Wt. Average			0.78	0.78	0.78	0.67	0.33	0.33

Naïve Bayes showed a lower performance, with high TPR of 0.80-0.85, the positive class and displayed a high recall but low precision. The ROC area was higher than for logistic but was not significantly higher. 

Decision Tree
Decision Tree: 
Oversampling, Boruta 

	N	Y
N	791	157
Y	18	33


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.705	0.336	0.680	0.705	0.692	0.726	NA	0.369
								
Class 1	0.689	0.336	0.663	0.689	0.976	0.726	NA	0.369
								
Wt. Average	0.747	0.299	0.715	0.747	0.731	0.726	NA	0.369



Decision Tree: 
Undersampling, Boruta

	N	Y
N	783	164
Y	26	26


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.82	0.17	0.96	0.82	0.89	0.66	0.18	0.14
								
Class 1	0.5	0.5	0.13	0.5	0.21	0.66	0.18	0.14
								
Wt. Average			0.92	0.80	0.85	0.66	0.18	0.14


Decision Tree: 
Oversampling, Information Gain 

	N	Y
N	778	137
Y	31	53


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.96	0.03	0.85	0.96	0.90	0.62	0.34	0.30
								
Class 1	0.27	0.72	0.63	0.27	0.38	0.62	0.34	0.30
								
Wt. Average			0.80	0.83	0.731	0.62	0.34	0.30


Decision Tree: 
Undersampling, Information Gain

	N	Y
N	783	156
Y	26	34


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.96	0.03	0.83	0.96	0.89	0.57	0.24	0.19
								
Class 1	0.17	0.82	0.56	0.17	0.27	0.57	0.24	0.19
								
Wt. Average			0.78	0.81	0.77	0.57	0.24	0.19


Decision Tree: 
Oversampling, RFE 

	N	Y
N	784	152
Y	25	38


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.96	0.03	0.83	0.96	0.89	0.58	0.27	0.22
								
Class 1	0.2	0.8	0.6	0.2	0.27	0.58	0.27	0.22
								
Wt. Average			0.78	0.81	0.77	0.58	0.27	0.22


Decision Tree: 
Undersampling, RFE

	N	Y
N	785	160
Y	24	30


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.97	0.029	0.83	0.97	0.89	0.56	0.22	0.17
								
Class 1	0.15	0.84	0.55	0.15	0.24	0.56	0.22	0.17
								
Wt. Average			0.77	0.81	0.77	0.56	0.22	0.17

Showed High TPR and is more balanced in general compared to previous algorithms. Although there was improvement compared to Naïve Bayes, some places like ROC, MCC, Precision are not as good when compared to Regression model. 

Random forest

Random forest: 
Oversampling, Boruta

	N	Y
N	797	158
Y	12	32


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.014	0.82	0.83	0.82	0.65	0.29	0.21
								
Class 1	0.17	0.83	0.41	0.49	0.45	0.65	0.29	0.21
								
Wt. Average			0.76	0.77	0.64	0.65	0.29	0.21


Random forest: 
Oversampling, information Gain

	N	Y
N	798	142
Y	11	48


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.021	0.84	0.84	0.83	0.57	0.26	0.32
								
Class 1	0.25	0.71	0.62	0.38	0.46	0.57	0.26	0.32
								
Wt. Average			0.76	0.77	0.75	0.57	0.26	0.32




Random forest: 
Oversampling, RFE

	N	Y
N	798	152
Y	18	38


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.97	0.027	0.82	0.79	0.80	0.62	0.3	0.24
								
Class 1	0.31	0.72	0.59	0.34	0.43	0.62	0.3	0.24
								
Wt. Average			0.67	0.64	0.65	0.62	0.3	0.24

Random forest: 
undersampling, information Gain

	N	Y
N	793	156
Y	16	34


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.032	0.84	0.84	0.82	0.67	0.31	0.22
								
Class 1	0.24	0.70	0.63	0.39	0.45	0.67	0.31	0.22
								
Wt. Average			0.77	0.76	0.64	0.67	0.31	0.22


Random forest: 
undersampling, RFE

	N	Y
N	794	164
Y	15	26


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.021	0.82	0.79	0.78	0.68	0.24	0.17
								
Class 1	0.34	0.73	0.65	0.38	0.45	0.68	0.24	0.17
								
Wt. Average			0.74	0.73	0.65	0.68	0.24	0.17

Random forest: 
undersampling, Boruta

	N	Y
N	792	150
Y	17	40


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.97	0.021	0.83	0.82	0.82	0.57	0.25	0.26
								
Class 1	0.32	0.73	0.64	0.34	0.44	0.57	0.25	0.26
								
Wt. Average			0.73	0.72	0.63	0.57	0.25	0.26

GBM
GBM: 
undersampling, Boruta

	N	Y
N	789	154
Y	20	36


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.021	0.82	0.83	0.82	0.66	0.29	0.23
								
Class 1	0.19	0.64	0.57	0.39	0.46	0.66	0.29	0.23
								
Wt. Average			0.72	0.68	0.63	0.66	0.29	0.23



GBM: 
oversampling, Boruta

	N	Y
N	793	147
Y	16	43


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.021	0.84	0.83	0.82	0.57	0.29	0.28
								
Class 1	0.22	0.71	0.59	0.43	0.48	0.57	0.29	0.28
								
Wt. Average			0.65	0.64	0.63	0.57	0.29	0.28

GBM: 
undersampling, information gain

	N	Y
N	795	134
Y	24	56


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.034	0.84	0.82	0.81	0.56	0.28	0.34
								
Class 1	0.26	0.73	0.64	0.38	0.44	0.56	0.28	0.34
								
Wt. Average			0.75	0.76	0.63	0.56	0.28	0.34


GBM: 
oversampling, information gain

	N	Y
N	791	153
Y	18	37


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.97	0.03	0.82	0.81	0.82	0.64	0.29	0.24
								
Class 1	0.31	0.68	0.67	0.36	0.55	0.64	0.29	0.24
								
Wt. Average			0.74	0.66	0.69	0.64	0.29	0.24

GBM: 
undersampling, RFE

	N	Y
N	794	141
Y	15	49


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.019	0.84	0.84	0.82	0.61	0.22	0.32
								
Class 1	0.27	0.74	0.61	0.33	0.42	0.61	0.22	0.32
								
Wt. Average			0.73	0.69	0.64	0.61	0.22	0.32

GBM: 
Oversampling, RFE

	N	Y
N	787	147
Y	22	43


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.97	0.032	0.83	0.84	0.82	0.67	0.23	0.27
								
Class 1	0.28	0.66	0.65	0.67	0.65	0.67	0.23	0.27
								
Wt. Average			0.76	0.77	0.72	0.67	0.23	0.27

SVM

SVM: 
undersampling, information gain

	N	Y
N	805	164
Y	4	26


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.021	0.83	0.81	0.82	0.59	0.29	0.19
								
Class 1	0.19	0.68	0.61	0.37	0.45	0.59	0.28	0.19
								
Wt. Average			0.76	0.75	0.64	0.59	0.28	0.19

SVM: 
oversampling, information gain

	N	Y
N	803	163
Y	6	27


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.99	0.021	0.81	0.79	0.8	0.54	0.28	0.20
								
Class 1	0.34	0.72	0.58	0.62	0.6	0.54	0.28	0.20
								
Wt. Average			0.72	0.73	0.73	0.54	0.28	0.20

SVM: 
oversampling, RFE

	N	Y
N	803	162
Y	6	


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.99	0.021	0.83	0.82	0.82	0.62	0.25	0.20
								
Class 1	0.19	0.68	0.61	0.37	0.44	0.62	0.25	0.20
								
Wt. Average			0.74	0.65	0.69	0.62	0.25	0.20

SVM: 
undersampling, RFE

	N	Y
N	804	168
Y	5	22


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.04	0.83	0.82	0.83	0.64	0.31	0.16
								
Class 1	0.32	0.73	0.61	0.39	0.46	0.64	0.31	0.16
								
Wt. Average			0.75	0.78	0.67	0.64	0.31	0.16


SVM: 
undersampling, boruta

	N	Y
N	798	172
Y	11	18


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.021	0.81	0.79	0.79	0.59	0.26	0.12
								
Class 1	0.29	0.73	0.58	0.56	0.57	0.59	0.26	0.12
								
Wt. Average			0.74	0.63	0.68	0.59	0.26	0.12

SVM: 
oversampling, boruta

	N	Y
N	798	164
Y	11	26


	TPR	FPR	Precision	Recall	F-measure	ROC	MCC	Kappa
Class 0	0.98	0.16	0.82	0.82	0.80	0.62	0.23	0.18
								
Class 1	0.14	0.24	0.70	0.68	0.65	0.62	0.23	0.18
								
Wt. Average			0.76	0.73	0.70	0.62	0.23	0.18


Discussion and Conclusion: 

Based on the results and outputs, logistic regression showed better performance than Naïve bayes, we can see it based on accuracy, TPR, FPR and ROC were worse in the Naïve Bayes model, compared to Logistic Regression. Logistic had TPR of 0.95 and higher, Precision of 0.95, while Naïve had TPR of around 0.72. So Logistic regression is a better model fit for predicting the majority class, but it costs a higher FPR. 
Decision Tree shows a better balanced compared to the previous two algorithms, especially when it is combined with oversampling and Boruta or Information Gain features. However, looking at these values there could be a small overfitting, so I believe that logistic regression is also a better model in this case, even though it is not as balanced as the decision tree, it is still giving us higher accuracy and in general seems like a better fit for this dataset. 
Based on the performance table, Random Forest have a better performance compared to SVM, offering a more balanced outcome across various metrics. Between GBM, SVM, and Random Forest, GBM achieves the highest performance. However, it's important to note that GBM exhibits signs of overfitting.

I think that in this case the choice of algorithm always depends on what are we trying to find and what is the goal of the experiment. In this experiment, the logistic regression seemed to perform better. 
Feature selection was also showing that after we use them they give better performance, which indicates that if we focus on important features we improve the model. 
Model Choice, Decision Tree and Logistic Regression appear to perform the best across different preprocessing and feature selection techniques. However, even though the decision tree is more balanced, I believe that the highest accuracy which gives Logistic Regression indicates that it is a better model in this case. 
	
	In order to predict something, we applied variety of different learning algorithms to this dataset. Our experiment took several steps, which are: preprocessing the data, balance it, use different features and lastly apply different algorithms. After using algorithms we used metrics such as TPR, FPR, Precision, Recall, F-Measure, ROC, MCC, Kappa to evaluate the models. I believe that this project was a useful learning process of data science and gave our group invaluable hands on experience. 





Division of Work: 

Our team consisted of 2 people, and we divided the work evenly. We made sure to contact each other on a regular basis to keep each other updated about latest changes on the project. We were going through the same steps, and using different techniques and models. 
	We started the preprocessing together, where someone would take care of missing values, someone would take care of repeating values and we finished the preprocessing part together without strict division in work. 
	We then implemented feature selectors where we were also working on it the same way we worked on the preprocessing. We chose 3 and implemented them after taking care of preprocessing dataset. 
	After that we each took 3 algorithms and each was working on 3 of them. We then came up with 18 different tables and combined our findings. After combining our findings we analyzed and evaluated important metrics to see which model performs the best. 
	Lastly, the report preparation was done together, we created tables and gathered our answers to one file, where we were able to finalize our project. 

