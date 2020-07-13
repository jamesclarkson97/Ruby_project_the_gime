require_relative('../db/sql_runner')

class Enrollment

    attr_reader :id 
    attr_accessor :member_id, :gym_class_id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @member_id = options['member_id'].to_i
        @gym_class_id = options['gym_class_id'].to_i
    end

    def save()
        sql = "INSERT INTO enrollments
        (member_id, gym_class_id)
        VALUES
        ($1, $2)
        RETURNING id"
        values = [@member_id, @gym_class_id]
        result = SqlRunner.run(sql, values)
        @id = result.first()['id'].to_i
    end

    def self.all()
        sql = "SELECT * FROM enrollments"
        results = SqlRunner.run(sql)
        self.map_items(results)
    end
    
    def self.find(id)
        sql = "SELECT * FROM enrollments
        WHERE id = $1"
        value = [id]
        result = SqlRunner.run(sql, value)
        self.new(result.first)
    end

    def update()
        sql = "UPDATE enrollments SET
        (member_id, gym_class_id) = ($1, $2)
        WHERE id = $3"
        values = [@member_id, @gym_class_id, @id]
        SqlRunner.run(sql, values)
    end

    def self.delete(id)
        sql = "DELETE FROM enrollments
        WHERE id = $1"
        value = [id]
        SqlRunner.run(sql, value)
    end

    def self.delete_all()
        sql = "DELETE FROM enrollments"
        SqlRunner.run( sql )
    end

    def gym_class()
        sql = "SELECT * FROM gym_classes
        WHERE id = $1"
        values = [@gym_class_id]
        result = SqlRunner.run(sql, values)
        GymClass.new(result.first)
    end

    # def member()
    #     sql = "SELECT * FROM members"

    def self.map_items(data)
        data.map {|enrollment| self.new(enrollment)}
    end

end