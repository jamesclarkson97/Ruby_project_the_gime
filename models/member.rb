require_relative('../db/sql_runner')

class Member

    attr_reader :id
    attr_accessor :first_name, :last_name, :active

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @active = options['active']
    end

    def save()
        sql = "INSERT INTO members
        (first_name, last_name, active)
        VALUES
        ($1, $2, $3)
        RETURNING id"
        values = [@first_name, @last_name, @active]
        result = SqlRunner.run(sql, values)
        @id = result.first()['id'].to_i
    end

    def self.all()
        sql = "SELECT * FROM members"
        results = SqlRunner.run(sql)
        self.map_items(results)
    end
    
    def self.find(id)
        sql = "SELECT * FROM members
        WHERE id = $1"
        value = [id]
        result = SqlRunner.run(sql, value)
        self.new(result.first)
    end

    def update()
        sql = "UPDATE members SET
        (first_name, last_name, active) = ($1, $2, $3)
        WHERE id = $4"
        values = [@first_name, @last_name, @active, @id]
        SqlRunner.run(sql, values)
    end

    def self.delete(id)
        sql = "DELETE FROM members
        WHERE id = $1"
        value = [id]
        SqlRunner.run(sql, value)
    end

    def self.delete_all()
        sql = "DELETE FROM members"
        SqlRunner.run(sql)
    end

    def self.map_items(data)
        data.map {|member| self.new(member)}
    end

end