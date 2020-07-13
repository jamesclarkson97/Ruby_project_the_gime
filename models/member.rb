require_relative('../db/sql_runner')

class Member

    attr_reader(:id, :first_name, :last_name)

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
    end

    def save()
        sql = "INSERT INTO members
        (first_name, last_name)
        VALUES
        ($1, $2)
        RETURNING id"
        values = [@first_name, @last_name]
        result = SqlRunner.run(sql, values)
        @id = result.first()['id'].to_i
    end

    def self.all()
        sql = "SELECT * FROM members"
        results = SqlRunner.run(sql)
        return results.map {|member| Member.new(member)}
    end
    
    def self.find(id)
        sql = "SELECT * FROM members
        WHERE id = $1"
        value = [id]
        result = SqlRunner.run(sql, value)
        return Member.new(result.first)
    end

end