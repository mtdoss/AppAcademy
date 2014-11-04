class NotesController < ApplicationController

  def index
  end

  def show

  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.save

    redirect_to track_url(@note.track_id)
  end


  private
  def note_params
    params.require(:note).permit(:track_id, :user_id, :text)
  end
end
