require_relative('../db/sql_runner')

class GymClass

    attr_reader(:id, :name)

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
        return results.map {|gym_class| GymClass.new(gym_class)}
    end
    
    def self.find(id)
        sql = "SELECT * FROM gym_classes
        WHERE id = $1"
        value = [id]
        result = SqlRunner.run(sql, value)
        return GymClass.new(result.first)
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

end