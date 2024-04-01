
-- ---------------------------BANK LOAN REPORT--------------------------------




------------------------A.	BANK LOAN REPORT | SUMMARY------------------------


--------------------Key Performance Indicators (KPIs) Requirements---------------


-- 1.	TOTAL LOAN APPLICATION

SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data


-- MONTH-TO-DATE TOTAL LOAN APPLICATION 

SELECT COUNT(id) AS MTD_Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12


-- PREVIOUS MONTH-TO-DATE TOTAL LOAN APPLICATION

SELECT COUNT(id) AS PMTD_Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11




-- 2. TOTAL FUNDED AMOUNT

SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data


-- MONTH-TO-DATE TOTAL FUNDED AMOUNT

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12


-- PREVIOUS MONTH-TO-DATE TOTAL FUNDED AMOUNT

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11




-- 3. TOTAL AMOUNT RECEIVED

SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data


-- MONTH-TO-DATE TOTAL AMOUNT RECEIVED

SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- PREVIOUS MONTH-TO-DATE TOTAL AMOUNT RECEIVED

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021




-- 4. AVERAGE INTEREST RATE

SELECT AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data


-- AVERAGE INTEREST RATE ROUNDED UP TO THE 4 SIGNIFICANT FIGURE

SELECT ROUND(AVG(int_rate), 4) * 100 AS Avg_Interest_Rate
FROM bank_loan_data


-- MONTH-TO-DATE AVERAGE INTEREST RATE ROUNDED UP TO THE 4 SIGNIFICANT FIGURE

SELECT ROUND(AVG(int_rate), 4) * 100 AS MTD_Avg_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- PREVIOUS MONTH-TO-DATE AVERAGE INTEREST RATE ROUNDED UP TO THE 4 SIGNIFICANT FIGURE

SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_Avg_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021




-- 5. AVERAGE DEBT TO RATIO ROUNDED UP

SELECT ROUND(AVG(dti),4)* 100 AS Avg_DTI 
FROM bank_loan_data


-- MONTH-TO-DATE AVERAGE DEBT TO RATIO ROUNDED UP

SELECT ROUND(AVG(dti),4)* 100 AS MTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- PREVIOUS MONTH-TO-DATE AVERAGE DEBT TO RATIO ROUNDED UP

SELECT ROUND(AVG(dti),4)* 100 AS PMTD_Avg_DTI 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021







-- ---------------------------Good Loan VS Bad Loan KPI’s---------------------

-- 1. GOOD LOAN ISSUED


-- GOOD LOAN PERCENTAGE

SELECT
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data


-- GOOD LOAN APPLICATION

SELECT COUNT(id) AS Good_loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


-- GOOD LOAN FUNDED AMOUNT

SELECT SUM(loan_amount) AS Good_Loan_Funded_Applications
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


-- GOOD LOAN TOTAL RECEIVED AMOUNT

SELECT SUM(total_payment) AS Good_Loan_Funded_Applications
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'





-- 2. BAD LOAN ISSUED


-- BAD LOAN PERCENTAGE

SELECT
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100)/
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data


-- BAD LOAN APPLICATIONS

SELECT COUNT(id) AS Bad_loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off'


-- BAD LOAN FUNDED AMOUNT

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount 
FROM bank_loan_data
WHERE loan_status = 'Charged Off'


-- BAD LOAN TOTAL RECEIVED AMOUNT

SELECT SUM(total_payment) AS Bad_Loan_Total_Received_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off'







------------------------------LOAN STATUS-----------------------------------


SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
FROM
        bank_loan_data
GROUP BY
        loan_status


SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status









--------------------------B.	BANK LOAN REPORT | OVERVIEW------------------


-- MONTHLY TRENDS BY ISSUE DATE 

SELECT 
	MONTH(issue_date) AS Month_Number, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


-- REGIONAL ANALYSIS BY STATE

SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state


-- LOAN TERMS ANALYSIS

SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term


-- EMPLOYEE LENGTH ANALYSIS

SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length


-- LOAN PURPOSE BREAKDOWN

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC


-- HOME OWNERSHIP ANALYSIS

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC


