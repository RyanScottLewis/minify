class String
  def constantize
    dup.constantize
  end
  
  def constantize!
    replace(self)  # TODO
  end
end
