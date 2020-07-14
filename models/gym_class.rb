require_relative('../db/sql_runner')

class GymClass

    attr_reader :id
    attr_accessor :name, :max_capacity

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @max_capacity = options['max_capacity'].to_i
    end

    def save()
        sql = "INSERT INTO gym_classes
        (name, max_capacity)
        VALUES
        ($1, $2)
        RETURNING id"
        values = [@name, @max_capacity]
        result = SqlRunner.run(sql, values)
        @id = result.first()['id'].to_i
    end

    def self.all()
        sql = "SELECT * FROM gym_classes"
        results = SqlRunner.run(sql)
        self.map_items(results)
    end
    
    def self.find(id)
        sql = "SELECT * FROM gym_classes
        WHERE id = $1"
        value = [id]
        result = SqlRunner.run(sql, value)
        self.new(result.first)
    end

    def update()
        sql = "UPDATE gym_classes SET
        (name, max_capacity) = ($1, $2)
        WHERE id = $3"
        values = [@name, @max_capacity, @id]
        SqlRunner.run(sql, values)
    end

    def self.delete(id)
        sql = "DELETE FROM gym_classes
        WHERE id = $1"
        value = [id]
        SqlRunner.run(sql, value)
    end

    def self.delete_all()
        sql = "DELETE FROM gym_classes"
        SqlRunner.run(sql)
    end

    def members()
        sql = "SELECT members.*
        FROM members
        INNER JOIN enrollments
        ON enrollments.member_id = members.id
        WHERE enrollments.gym_class_id = $1"
        values = [@id]
        results = SqlRunner.run(sql, values)
        Member.map_items(results)
    end

    def check_availability()
        currently_enrolled = members().count
        if currently_enrolled < @max_capacity
            return true
        else
            return false
        end
    end

    def self.map_items(data)
        data.map {|gym_class| self.new(gym_class)}
    end

end