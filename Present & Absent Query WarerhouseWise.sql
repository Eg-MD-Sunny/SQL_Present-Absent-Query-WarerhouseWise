Select		EmployeeAttendance.ForDate,
			BadgeId,
			FullName, 
			Designation.DesignationName,
			(case	when Designation.DepartmentTypeId=1 then 'HQ'
					when Designation.DepartmentTypeId=2 then 'Customer Service And Telesales'
					when Designation.DepartmentTypeId=3 then 'Client Acquisition'
					when Designation.DepartmentTypeId=4 then 'Sourcing'
					when Designation.DepartmentTypeId=5 then 'Accounts'
					when Designation.DepartmentTypeId=6 then 'Marketing'
					when Designation.DepartmentTypeId=7 then 'Resources'
					when Designation.DepartmentTypeId=8 then 'Logistics'
					when Designation.DepartmentTypeId=9 then 'Operation'
					when Designation.DepartmentTypeId=10 then 'Engineering'
					when Designation.DepartmentTypeId=11 then 'Go Go Bangla'
					when Designation.DepartmentTypeId=12 then 'Vegetable Network'
					when Designation.DepartmentTypeId=13 then 'Cahalao'
					when Designation.DepartmentTypeId=14 then 'WFP Distribiution'
					when Designation.DepartmentTypeId=15 then 'Pharmacy' 
				else null end)[DepartmentType Name],
			WarehouseId, Warehouse.Name,
			joinedon,
			ShiftStartTime1,
			ShiftStartTime2,
			cast ( EmployeeAttendance.FingerPrintedOn as Time ) [FingerPrintedOn],
			Case 	when ( EmployeeAttendance.IsExpected=1 and EmployeeAttendance.AccountingEventId is not null and EmployeeAttendance.OnPaidLeave=0 ) then 'Duty On'
					When ( EmployeeAttendance.IsExpected=1 and EmployeeAttendance.AccountingEventId is null ) then 'Absent Or Unpaid Leave' 
					When ( EmployeeAttendance.IsExpected=1 and EmployeeAttendance.OnPaidLeave=1 ) then 'OnPaidLeave'
					When ( EmployeeAttendance.IsExpected=0 ) then 'Day Off'
					else 'Others' End [Duty Type],
			Case	When EmployeeAttendance.islate = 1 then 'Late' else ''
					end [IsLate]


from		Employee 
	join	EmployeeAttendance on EmployeeAttendance.EmployeeId = Employee.Id
	join	Designation on Designation.Id = Employee.DesignationId 
	left join	Warehouse on Warehouse.Id = Employee.WarehouseId


Where		ForDate >= '2022-02-23'
	and		ForDate < '2022-02-24'	