require "employee"

class Startup
	attr_reader :name, :funding, :salaries, :employees
	def initialize(name,funding,salaries)
		@name = name
		@funding = funding
		  #   salaries = {
		    #   "CEO"=>5000,
		    #   "CTO"=>4200,
		    #   "Software Engineer"=>3000,
		    #   "Junior Developer"=>2400
		    # }
		@salaries = salaries
		@employees = []
	end

	def valid_title?(title)
		@salaries.has_key?(title)
	end

	def >(other_startup)
		self.funding > other_startup.funding
	end

	def hire(employee_name,title)
		if self.valid_title?(title)
			@employees << Employee.new(employee_name,title)
		else
			raise "title is invalid!"
		end
	end

	def size
		@employees.length
	end

	def pay_employee(employee)
		money_owned = @salaries[employee.title]
		if @funding >= money_owned
			employee.pay(money_owned)
			@funding -= money_owned
		else
			raise "not enough funding!"
		end
	end

	def payday
		@employees.each do |employee|
			self.pay_employee(employee)
		end
	end

	def average_salary
		sum = 0
		@employees.each do |employee|
			sum += @salaries[employee.title]
		end

		sum  / (@employees.length * 1.0)
	end

	def close
		@employees = []
		@funding = 0
	end

	def acquire(startup)


		@funding += startup.funding

		startup.salaries.each do |title,salary|
			if !@salaries.has_key?(title)
				@salaries[title] = salary
			end
		end

		# hire employees
		@employees += startup.employees

		# close the other startup
		startup.close()
	end


end
