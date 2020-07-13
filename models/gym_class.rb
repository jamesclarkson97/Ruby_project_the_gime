require_relative('../db/sql_runner')

class GymClass

    attr_reader :id
    attr_accessor :name

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
    end

    def save()
        sql = "INSERT INTO gym_classes
        (name)
        VALUES
        ($1)
        RETURNING id"
        values = [@name]
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
        name = $1
        WHERE id = $2"
        values = [@name, @id]
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

    def self.map_items(data)
        data.map {|gym_class| self.new(gym_class)}
    end

end